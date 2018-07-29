## Spring 注解

1. @Autowired

可以在成员变量、方法、构造方法中添加注解以注入依赖对象。默认是按照类（byType）来匹配bean。构造方法和成员变量可以是私有的。
@Qualifier 是用来配合@Autowired注解来限定bean的名称，它可以放在成员变量中，构造方法和setter方法的参数上。

	@Autowired
	@Qualifier("userService")
	private UserService userService;

2. @Resource （JSR-250标准注解，推荐使用它来代替Spring专有的@Autowired注解） 
和@Autowired类似，不过Resource默认按照名称(byName)注入依赖bean，当没有匹配到名称时再按照类(byType)来注入依赖bean。
@Resource 有两个属性是比较重要的，分别是 name 和 type，Spring 将@Resource 注释的 name 属性解析为 Bean 的名字，而 type 属性则解析为 Bean 的类型。所以如果使用 name 属性，则使用 byName 的自动注入策略，而使用 type 属性时则使用 byType 自动注入策略。如果既不指定 name 也不指定 type 属性，这时将通过反射机制使用 byName 自动注入策略。

3. @PostConstruct（JSR-250） 
在方法上加上注解@PostConstruct，这个方法就会在Bean初始化之后被Spring容器执行（注：Bean初始化包括，实例化Bean，并装配Bean的属性（依赖注入））。 

它的一个典型的应用场景是，当你需要往Bean里注入一个其父类中定义的属性，而你又无法复写父类的属性或属性的setter方法时，如：

	public class UserDaoImpl extends HibernateDaoSupport implements UserDao {    
	    private SessionFactory mySessionFacotry;    
	    @Resource    
	    public void setMySessionFacotry(SessionFactory sessionFacotry) {    
		this.mySessionFacotry = sessionFacotry;    
	    }    
	    @PostConstruct    
	    public void injectSessionFactory() {    
		super.setSessionFactory(mySessionFacotry);    
	    }    
	    ...    
	}    

4. @PreDestroy（JSR-250） 
在方法上加上注解@PreDestroy，这个方法就会在Spring 容器关闭前销毁Boss Bean 的时候被触发执行。由于我们当前还没有需要用到它的场景，这里不不去演示。其用法同@PostConstruct。



spring mvc 使用



