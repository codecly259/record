
## aop

### aspectj:专门开发动态代理的框架


## spring 整合 hibernate

事务管理的配置

1. 加入annotation.xsd
2. 加入txManager bean
3. <tx:annotation-driven>
4. 在需要事务的地方加@Transactional
5. 需要注意使用SessionFactory.getCurrentSession ，不要使用openSession

dataSource配置

<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
    <property name="driverClassName" value="${jdbc.driverClassName}" />
    <property name="url" value="${jdbc.url}" />
    <property name="username" value="${jdbc.username}" />
    <property name="password" value="${jdbc.password}" />
</bean>


sessionFactory配置

<bean id="sessionFactory" class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
    <property name="dataSource" ref="dataSource" />
    <property name="mappingResources">
        <list>
            <value>org/springframework/samples/petclinic/hibernate/petclinic.hbm.xml</value>
        </list>
    </property>
    <property name="hibernateProperties">
        <value>
            hibernate.dialect=${hibernate.dialect}
        </value>
    </property>
</bean>


## 声明式的事务管理配置
<!-- JDBC dataSource transactionManager -->
<bean id="txManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource"/>
</bean>

<!-- HibernateTransactionManager -->
<bean id="txManager" class="org.springframework.orm.hibernate3.HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>


## 一个完整的例子（spring + hibernate数据源和事务管理配置）
<?xml version="1.0" encoding="UTF-8"?>  
<beans xmlns="http://www.springframework.org/schema/beans"  
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
    xmlns:context="http://www.springframework.org/schema/context"  
    xmlns:mvc="http://www.springframework.org/schema/mvc"  
    xsi:schemaLocation="http://www.springframework.org/schema/beans   
    http://www.springframework.org/schema/beans/spring-beans.xsd">  
      
    <!-- 配置数据源 -->  
    <bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource" >  
        <property name="driverClassName" value="com.mysql.jdbc.Driver"></property>  
        <property name="url" value="jdbc:mysql://localhost/test_ssh"></property>  
        <property name="username" value="root"></property>  
        <property name="password" value="1"></property>  
    </bean>  
      
    <!-- 配置SessionFactory -->  
    <bean id="sessionFactory" class="org.springframework.orm.hibernate4.LocalSessionFactoryBean">  
        <property name="dataSource" ref="dataSource" />  
        <property name="hibernateProperties">  
            <props>  
                <prop key="hibernate.dialect">org.hibernate.dialect.MySQLDialect</prop>  
                <prop key="hibernate.hbm2ddl.auto">update</prop>  
                <prop key="hibernate.show_sql">true</prop>  
                <prop key="hibernate.format_sql">true</prop>  
            </props>  
        </property>  
        <property name="annotatedClasses">  
            <list>  
                <value>com.tgb.entity.User</value>  
            </list>  
        </property>  
    </bean>  
      
    <!-- 配置一个事务管理器 -->  
    <bean id="transactionManager" class="org.springframework.orm.hibernate4.HibernateTransactionManager">  
        <property name="sessionFactory" ref="sessionFactory"/>  
    </bean>  
      
    <!-- 配置事务，使用代理的方式 -->  
    <bean id="transactionProxy" class="org.springframework.transaction.interceptor.TransactionProxyFactoryBean" abstract="true">    
        <property name="transactionManager" ref="transactionManager"></property>    
        <property name="transactionAttributes">    
            <props>    
                <prop key="add*">PROPAGATION_REQUIRED,-Exception</prop>    
                <prop key="modify*">PROPAGATION_REQUIRED,-myException</prop>    
                <prop key="del*">PROPAGATION_REQUIRED</prop>    
                <prop key="*">PROPAGATION_REQUIRED</prop>    
            </props>    
        </property>    
    </bean>   
</beans>  

