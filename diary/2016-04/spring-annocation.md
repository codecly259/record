## Spring ע��

1. @Autowired

�����ڳ�Ա���������������췽�������ע����ע����������Ĭ���ǰ����ࣨbyType����ƥ��bean�����췽���ͳ�Ա����������˽�еġ�
@Qualifier ���������@Autowiredע�����޶�bean�����ƣ������Է��ڳ�Ա�����У����췽����setter�����Ĳ����ϡ�

	@Autowired
	@Qualifier("userService")
	private UserService userService;

2. @Resource ��JSR-250��׼ע�⣬�Ƽ�ʹ����������Springר�е�@Autowiredע�⣩ 
��@Autowired���ƣ�����ResourceĬ�ϰ�������(byName)ע������bean����û��ƥ�䵽����ʱ�ٰ�����(byType)��ע������bean��
@Resource �����������ǱȽ���Ҫ�ģ��ֱ��� name �� type��Spring ��@Resource ע�͵� name ���Խ���Ϊ Bean �����֣��� type ���������Ϊ Bean �����͡��������ʹ�� name ���ԣ���ʹ�� byName ���Զ�ע����ԣ���ʹ�� type ����ʱ��ʹ�� byType �Զ�ע����ԡ�����Ȳ�ָ�� name Ҳ��ָ�� type ���ԣ���ʱ��ͨ���������ʹ�� byName �Զ�ע����ԡ�

3. @PostConstruct��JSR-250�� 
�ڷ����ϼ���ע��@PostConstruct����������ͻ���Bean��ʼ��֮��Spring����ִ�У�ע��Bean��ʼ��������ʵ����Bean����װ��Bean�����ԣ�����ע�룩���� 

����һ�����͵�Ӧ�ó����ǣ�������Ҫ��Bean��ע��һ���丸���ж�������ԣ��������޷���д��������Ի����Ե�setter����ʱ���磺

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

4. @PreDestroy��JSR-250�� 
�ڷ����ϼ���ע��@PreDestroy����������ͻ���Spring �����ر�ǰ����Boss Bean ��ʱ�򱻴���ִ�С��������ǵ�ǰ��û����Ҫ�õ����ĳ��������ﲻ��ȥ��ʾ�����÷�ͬ@PostConstruct��




