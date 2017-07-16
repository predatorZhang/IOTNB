package com.casic.iot.sysLog.manager;

import com.casic.iot.core.hibernate.HibernateEntityDao;
import com.casic.iot.core.page.Page;
import com.casic.iot.core.util.StringUtils;
import com.casic.iot.person.manager.RegistManager;
import com.casic.iot.sysLog.domain.SysLog;
import com.casic.iot.sysLog.dto.SysLogDTO;
import com.casic.iot.util.DataTable;
import com.casic.iot.util.DataTableParameter;
import com.casic.iot.util.DateUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by test203 on 2017/6/21.
 */
@Service
public class SysLogManager extends HibernateEntityDao<SysLog> {

    @Resource
    private RegistManager registManager;
    public Criteria getCriteria() {
        return getSession().createCriteria(SysLog.class);
    }

    public DataTable<SysLogDTO> pageQuery(DataTableParameter parameter,SysLogDTO sysLogDTO,HttpSession session) {
        try {
            DataTable<SysLogDTO> dt = new DataTable<SysLogDTO>();
            String username = (String) session.getAttribute(com.casic.iot.util.StringUtils.SYS_USER);
            if (username == null || username.isEmpty()) {
                return dt;
            }

            int start = parameter.getiDisplayStart();
            int pageSize = parameter.getiDisplayLength();
            int pageNo = (start / pageSize) + 1;

            Criteria criteria = getCriteria();
            criteria.addOrder(Order.desc("id"));
            if (StringUtils.isNotBlank(parameter.getsSearch())) {
                criteria.add(Restrictions.like("createUser", "%"+parameter.getsSearch()+"%"));
            }
             criteria.add(Restrictions.eq("createUser",username));
            if(sysLogDTO!=null){
                if (StringUtils.isNotBlank(sysLogDTO.getOperationType())) {
                    criteria.add(Restrictions.like("operationType", sysLogDTO.getOperationType(), MatchMode.ANYWHERE));
                }
                if (StringUtils.isNotBlank(sysLogDTO.getContent())) {
                    criteria.add(Restrictions.like("content", sysLogDTO.getContent(), MatchMode.ANYWHERE));
                }
                if(StringUtils.isNotBlank(sysLogDTO.getBeginDate())){
                    criteria.add(Restrictions.ge("createTime", DateUtils.sdf1.parse(sysLogDTO.getBeginDate())));
                }
                if(StringUtils.isNotBlank(sysLogDTO.getEndDate())){
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(DateUtils.sdf1.parse(sysLogDTO.getEndDate()));
                    calendar.add(Calendar.DATE, 1);
                    criteria.add(Restrictions.lt("createTime", calendar.getTime()));
                }
            }
            Page page = pagedQuery(criteria, pageNo, pageSize);

            List<SysLog> dtoList = (List<SysLog>) page.getResult();
            List<SysLogDTO> dtos = SysLogDTO.ConvertToDTOs(dtoList);
            dt.setAaData(dtos);
            dt.setiTotalDisplayRecords((int) page.getTotalCount());
            dt.setsEcho(parameter.getsEcho());
            dt.setiTotalRecords((int) page.getTotalCount());
            return dt;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<SysLogDTO> listTop5(String username) {

        Criteria criteria = getCriteria();
        criteria.setFirstResult(0);
        criteria.setMaxResults(5);
        criteria.addOrder(Order.desc("createTime"));
        criteria.add(Restrictions.eq("createUser", username));

        List<SysLog> sysLogs = criteria.list();
        List<SysLogDTO> sysLogDTOs = SysLogDTO.ConvertToDTOs(sysLogs);
        return sysLogDTOs;

    }
}
