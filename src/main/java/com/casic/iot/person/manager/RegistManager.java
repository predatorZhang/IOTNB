package com.casic.iot.person.manager;

import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.page.Page;
import com.casic.iot.person.domain.IndividualUser;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.dto.RegistDTO;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.StringUtils;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.io.File;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.util.*;

/**
 * Created by yxw on 2017/6/22.
 */
@Service
public class RegistManager extends HibernateEntityDao<Regist> {


    @Transactional
    public boolean login(RegistDTO registDTO, HttpSession session) {

        try {
            if (registDTO.getUserType().equals("0")) {
                //企业用户
                Criteria criteria = getSession().createCriteria(Regist.class);
                criteria.add(Restrictions.eq("enterpriseName", registDTO.getEnterpriseName()));
                criteria.add(Restrictions.eq("passWord", registDTO.getPassWord()));
                criteria.add(Restrictions.eq("active", 1));
                Regist regist = (Regist) criteria.setMaxResults(1).uniqueResult();
                if (regist == null) {
                    return false;
                }
                session.setAttribute(StringUtils.SYS_USER, regist.getEnterpriseName());
                session.setAttribute(StringUtils.SYS_DBID, regist.getDbId());

            } else {
                //个人用户
                Criteria criteria = getSession().createCriteria(IndividualUser.class);
                criteria.add(Restrictions.eq("userName", registDTO.getEnterpriseName()));
                criteria.add(Restrictions.eq("password", registDTO.getPassWord()));
                criteria.add(Restrictions.eq("active", 1));
                IndividualUser individualUser = (IndividualUser) criteria.setMaxResults(1).uniqueResult();
                if (individualUser == null) {
                    return false;
                }
                session.setAttribute(StringUtils.SYS_USER, individualUser.getUserName());
                session.setAttribute(StringUtils.SYS_DBID, individualUser.getDbId());
            }
            ServletContext application = session.getServletContext();
            HashSet sessions = (HashSet) application.getAttribute("sessions");
            if (sessions == null) {
                sessions = new HashSet();
                application.setAttribute("sessions", sessions);
            }
            sessions.add(session);
            application.setAttribute("sessions", sessions);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String saveLicense(MultipartFile file) throws Exception {
        String fileNames = "";
        String fileBuffers = "";
        try {
            fileNames = file.getOriginalFilename();
            byte[] fis = file.getBytes();
            fileBuffers = new String(Base64.encode(fis, Base64.BASE64DEFAULTLENGTH));

            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            String strDirPath = request.getSession().getServletContext().getRealPath("");

            FileOutputStream fos = null;
            String image_toDir = strDirPath + "\\files";//存储路径
            String imageName = "";

            if (fileBuffers != null && fileNames != null) {
                imageName += "files\\" + fileNames + ",";
                byte[] buffer = new BASE64Decoder().decodeBuffer(fileBuffers);//对android传过来的图片字符串进行解码
                File destDir = new File(image_toDir);
                if (!destDir.exists())
                    destDir.mkdirs();
                File imageFile = new File(destDir, fileNames);
                fos = new FileOutputStream(imageFile);//保存图片
                fos.write(buffer);
                fos.flush();
                fos.close();
            }

            return imageName.substring(0, imageName.length() - 1);
        } catch (Exception ex) {
            ex.printStackTrace();
            return "";
        }
    }

    public DataTable<RegistDTO> pageQueryRegistDto(DataTableParameter parameter, HttpSession session) throws ParseException {
        int start = parameter.getiDisplayStart();
        int pageSize = parameter.getiDisplayLength();
        int pageNo = (start / pageSize) + 1;
        Criteria criteria = getSession().createCriteria(Regist.class);
        if (StringUtils.isNotBlank(parameter.getsSearch())) {
            criteria.add(Restrictions.like("enterpriseName", parameter.getsSearch(), MatchMode.ANYWHERE));
        }
        Page page = pagedQuery(criteria, pageNo, pageSize);
        List<RegistDTO> registDTOs = RegistDTO.ConvertToDTOs((List<Regist>) page.getResult());
        DataTable<RegistDTO> dt = new DataTable<RegistDTO>();
        dt.setAaData(registDTOs);
        dt.setiTotalDisplayRecords((int) page.getTotalCount());
        dt.setsEcho(parameter.getsEcho());
        dt.setiTotalRecords((int) page.getTotalCount());
        return dt;
    }

    public boolean updateStatus(String dbId, String status) {
        String hql = "update Regist r set r.active=" + status + " where r.dbId=" + dbId;
        Query query = this.getSession().createQuery(hql);
        int ret = query.executeUpdate();
        return ret > 0;
    }

    /**
     *
     * @param statType 0新增 1累计
     * @param statStyle 0年 1月 2日
     * @param industry 行业
     * @param beginDate 统计开始时间
     * @param endDate 统计结束时间
     * @return
     */
    public List statUsers(int statType,int statStyle,String industry,String beginDate,String endDate){
        String groupStyle = "",condition ="";
        if(statStyle==0) groupStyle = "to_char(registerdate,'yyyy')";
        else if(statStyle==1) groupStyle = "to_char(registerdate,'yyyy-mm')";
        else if(statStyle==2) groupStyle = "to_char(registerdate,'yyyy-mm-dd')";
        if(StringUtils.isNotBlank(industry)&&!industry.equals("全部")){
            condition = " and industry = '"+industry+"' ";
        }
        if(StringUtils.isNotBlank(beginDate)){
            condition +=" and registerdate>= to_date('"+beginDate+"','yyyy-mm-dd') ";
        }
        if(StringUtils.isNotBlank(endDate)){
            condition +=" and registerdate< (to_date('"+endDate+"','yyyy-mm-dd')+interval '1' day) ";
        }
        String sql = "select "+groupStyle+" ,count(1) from alarm_alarm_record where " +
                "1=1 "+condition+
                " group by "+groupStyle +" order by "+ groupStyle +" asc";

        Query query =this.getSession().createSQLQuery(sql);
        List list = query.list();//增量值
        if(statType==1){//统计总量
            int count = 0;
            if(com.casic.iot.core.util.StringUtils.isNotBlank(beginDate)){//获取查询日期之前设备数量
                String sql2 = "select count(1) from alarm_alarm_record where registerdate< to_date('"+beginDate+"','yyyy-mm-dd')";
                Query query1 = this.getSession().createSQLQuery(sql2);
                List countList = query1.list();
                count =Integer.valueOf(countList.get(0).toString());
            }
            List<Object[]> res = new ArrayList<Object[]>();
            int curSum = count;
            for(int i = 0;i<list.size();i++){//遍历修正每一个增量值为总量
                int c = Integer.valueOf(((Object[])list.get(i))[1].toString());
                Object[] obj= {((Object[])list.get(i))[0],curSum+c};
                res.add(obj);
                curSum +=c;
            }
            return res;
        }
        return list;
    }

}
