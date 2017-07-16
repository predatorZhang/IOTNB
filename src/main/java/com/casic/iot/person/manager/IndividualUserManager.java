package com.casic.iot.person.manager;

import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.page.Page;
import com.casic.iot.person.domain.IndividualUser;
import com.casic.iot.person.domain.Regist;
import com.casic.iot.person.dto.IndividualUserDTO;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.StringUtils;
import com.casic.iot.xls.ExportExcel;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxw on 2017/6/22.
 */
@Service
public class IndividualUserManager extends HibernateEntityDao<IndividualUser> {

    private RegistManager registManager;

    @Resource
    public void setRegistManager(RegistManager registManager) {
        this.registManager = registManager;
    }

    public DataTable<IndividualUserDTO> queryIndividualUserByPage(DataTableParameter parameter,HttpSession session) throws ParseException
    {
        int start = parameter.getiDisplayStart();
        int pageSize = parameter.getiDisplayLength();
        int pageNo = (start / pageSize) + 1;
        Regist regist = registManager.findUniqueBy("dbId", session.getAttribute(StringUtils.SYS_DBID));
        Criteria criteria = getSession().createCriteria(IndividualUser.class);
        criteria.addOrder(Order.desc("dbId"));
        criteria.add(Restrictions.eq("regist",regist));
        if(StringUtils.isNotBlank(parameter.getsSearch()))
        {
            criteria.add(Restrictions.like("userName", "%" + parameter.getsSearch() + "%"));
        }

        criteria.add(Restrictions.eq("active",1));

        Page page = pagedQuery(criteria,pageNo,pageSize);

        List<IndividualUserDTO> individualUserDTOs = IndividualUserDTO.ConvertToDTOs((List<IndividualUser>) page.getResult());
        DataTable<IndividualUserDTO> dt = new DataTable<IndividualUserDTO>();
        dt.setAaData(individualUserDTOs);
        dt.setiTotalDisplayRecords((int) page.getTotalCount());
        dt.setsEcho(parameter.getsEcho());
        dt.setiTotalRecords((int) page.getTotalCount());
        return dt;
    }

    public List<IndividualUserDTO> queryUsers(String search,HttpSession session){
        Regist regist = registManager.findUniqueBy("dbId", session.getAttribute(StringUtils.SYS_DBID));
        Criteria criteria = getSession().createCriteria(IndividualUser.class);
        criteria.addOrder(Order.desc("dbId"));
        criteria.add(Restrictions.eq("regist",regist));
        if(StringUtils.isNotBlank(search))
        {
            criteria.add(Restrictions.like("userName", "%" +search + "%"));
        }
        criteria.add(Restrictions.eq("active",1));
        List<IndividualUserDTO> individualUserDTOs = IndividualUserDTO.ConvertToDTOs(criteria.list());
        return individualUserDTOs;
    }
    public Map<String, Object> expUsersToExcel(String search,HttpSession session, String path) throws ParseException, IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        List<IndividualUserDTO> dtoList =queryUsers(search, session);
        String[] headers = {"用户名","密码" ,"电话", "邮箱"};
        OutputStream out = new FileOutputStream(path);
        List<String[]> exportDatas = new ArrayList<String[]>(dtoList.size());
        for(IndividualUserDTO individualUserDTO:dtoList){
            String[] line = {individualUserDTO.getUserName(),individualUserDTO.getPassword(),individualUserDTO.getPhone(),individualUserDTO.getEmail()};
            exportDatas.add(line);
        }
        map.put("success", ExportExcel.exportExcel("报警记录", headers, exportDatas, out));
        map.put("message", "报警记录成功！");
        return map;
    }
}
