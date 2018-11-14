package com.qf.oa.realm;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.Resc;
import com.qf.oa.service.IEmpService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Author ken
 * @Time 2018/11/6 14:07
 * @Version 1.0
 */
@Component
public class OARealm extends AuthorizingRealm {

    @Autowired
    private IEmpService empService;

    /**
     * 授权管理
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //访问数据库 用户的授权

        //获得登录者的信息
        Employee employee = (Employee) principals.getPrimaryPrincipal();
        //获得登录者的权限信息
        List<Resc> rescs = employee.getRescs();

        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        for (Resc resc : rescs) {
            if(resc.getRpath() != null || !resc.getRpath().equals("")) {
                authorizationInfo.addStringPermission(resc.getRpath());
            }
        }

        return authorizationInfo;
    }

    /**
     * 登录认证
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获得用户输入的用户名
        String email = (String) token.getPrincipal();
        //调用service层获得用户信息
        Employee employee = empService.queryByEmail(email);
        AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(employee, employee.getPassword(), this.getName());
        return authenticationInfo;
    }
}
