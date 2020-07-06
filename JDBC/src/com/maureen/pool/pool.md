数据库连接池的目的是为了减少频繁开关连接的时间，提高整个系统过得相应能力。
通过分析发现应该具备几个属性值：
1、初始大小
2、每次扩容的大小
3、连接池的最大个数
4、空闲连接的死亡时间

各种数据库连接池：
1、DBCP (几乎不再使用)
     官网说明：http://commons.apache.org/proper/commons-dbcp/index.html
     需要导入两个包：commons-dbcp2和commons-pool2
     配置参数: http://commons.apache.org/proper/commons-dbcp/configuration.html
2、C3P0
    解释说明：https://www.mchange.com/projects/c3p0/
    导入包：c3p0-0.9.5.4
    配置c3p0:：
        如果是properties的方式，配置文件名必须得是c3p0.properties。可以配置的属性：https://www.mchange.com/projects/c3p0/#configuration_properties
        如果是xml的方式，配置文件名必须得是c3p0-config.xml。格式规范：
3、Druid
    Alibaba Druid：https://github.com/alibaba/druid
    配置文件中属性：https://github.com/alibaba/druid/wiki/DruidDataSource%E9%85%8D%E7%BD%AE
    需要导入的包：druid-1.1.9.jar
4、hikariCP
    地址：https://github.com/brettwooldridge/HikariCP
    需要导入两个包：HikariCP-3.4.1.jar和slf4j-api-2.0.0-alpha1.jar