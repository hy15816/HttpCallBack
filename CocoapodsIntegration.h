//
//  CocoapodsIntegration.h
//  HttpCallBack
//
//  Created by AEF-RD-1 on 15/12/29.
//  Copyright © 2015年 yim. All rights reserved.
//

//说明：CocoaPods(一个管理第三方类库的库),集成及使用方法
/**
 一、安装:需要ruby环境
    1.ruby环境搭建,先打开终端
    1.1查看当前ruby版本，输入:ruby -v
    1.2若版本太低看更新ruby，输入:sudo gem update -- system
        升级成功显示：RubyGems system software updated
 二、安装cocoapods:
    1.输入：sudo gem install cocoapods 
        出现ERROR: Could not find a valid gem ‘bundle’ (>= 0), here is why:
        Unable to download data from https://rubygems.org/ - Errno::ECONNRESET: Connection reset by peer - SSL_connect (https://rubygems.org/latest_specs.4.8.gz)
    这种情况是被墙了，需要把ruby镜像只想taobao，
    移除: gem sources -- remove https://rubygems.org/
    添加: gem sources -a https://ruby.taobao.org/
    检查: gem sources -l  <用来检查是否替换镜像成功>
            出现：*** CURRENT SOURCES *** 是为成功了
    2.再次输入：sudo gem install cocoapods
        2.1输入密码->开始下载....
            最后显示
            WARNING:  Unable to pull data from 'https://rubygems.org/': Errno::ECONNRESET: Connection reset by peer - SSL_connect (https://rubygems.org/specs.4.8.gz)
            ?? gems installed
            就已经成功了
    3.使用cocoapods：
        3.1 终端： cd 项目总目录(即包含：Xxx、Xxx.xcodeproj、XxxTests、<XxxUITests>)
            （可直接把项目拖到终端直接过去目录）
        3.2 创建Podfile文件，输入：vim Podfile
            出现"Podfile" [New File]
        3.3 输入：i,进入编辑模式
        3.4 输入：platform:ios,'7.0'
                 pod 'MJRefresh'
        3.5 按Esc键，并输入“:”号进入vim命令模式，然后在冒号后边输入wq
        3.6 回车后发现 Xxx项目总目录中多一个Podfile文件
        3.7 若没有退出当前还是在项目目录下的，若不是则要cd到目录，<见3.1>
        3.8 输入 pod install,等待一会，
            出现类似：
             Creating shallow clone of spec repo `master` from `https://github.com/CocoaPods/Specs.git`
             
             Updating local specs repositories
             Analyzing dependencies
             Downloading dependencies
             Installing MBProgressHUD (0.9.2)
             Generating Pods project
             Integrating client project
             
             [!] Please close any current Xcode sessions and use `HttpCallBack.xcworkspace` for this project from now on.
             Sending stats
             Pod installation complete! There is 1 dependency from the Podfile and 1 total pod
             installed.
            表示成功了，
 
            3.8.1：失败-->
                 /Library/Ruby/Site/2.0.0/rubygems/dependency.rb:318:in `to_specs': Could not find 'cocoapods' (>= 0) among 18 total gem(s) (Gem::LoadError)
                 Checked in 'GEM_PATH=/Users/aef-rd-1/.gem/ruby/2.0.0:/Library/Ruby/Gems/2.0.0:/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/gems/2.0.0', execute `gem env` for more information
                    from /Library/Ruby/Site/2.0.0/rubygems/dependency.rb:327:in `to_spec'
                    from /Library/Ruby/Site/2.0.0/rubygems/core_ext/kernel_gem.rb:64:in `gem'
                    from /usr/local/bin/pod:22:in `<main>'
 
 
                解决办法：
                sudo gem install -n /usr/local/bin cocoapods
                pod install
 
        3.9 关闭原先打开的工程，再次打开，<原来打开项目使用Xxx.xcodeproj,现在使用Xxx.xcworkspace就好了>
        3.10 导入头文件，
 
    4.已安装cocoapods，怎么添加或更新第三方类库？
        4.1 更新，打开终端输入:pod update
        4.2 添加，在项目中打开文件Podfile ，如添加： pod 'SVProgressHUD',
                                           如： pod 'AFNetworking', '~>3.0'
            在目录下(若不在工程目录下先cd)执行：pod update
        4.3 删除：。。。。。
 
 
 
 
    5.续
        5.1安装cocoapods时，输入 sudo gem install cocoapods 报错
         ERROR:  While executing gem ... (Gem::RemoteFetcher::FetchError)
         Errno::ECONNRESET: Connection reset by peer - SSL_connect (https://api.rubygems.org/quick/Marshal.4.8/cocoapods-0.39.0.gemspec.rz)
        5.2 输入 gem soureces -- remove https://rubygems.org/  出现
         *** CURRENT SOURCES ***
         
         https://rubygems.org/
         https://ruby.taobao.org/
         https://ruby.taobao.org
 
        -------未解决(怎么也移除不了)
        解决：执行 sudo gem sources  --remove https://rubygems.org/
        剩下一个
 
 
 
    6.续。
        输入 sudo gem install cocoapods
        出现 While executing gem ... (Errno::EPERM)
            Operation not permitted - /usr/bin/pod
 
 方案一：
 
 $ mkdir -p $HOME/Software/ruby
 $ export GEM_HOME=$HOME/Software/ruby
 $ gem install cocoapods
 [...]
 1 gem installed cocoapods
 $ export PATH=$PATH:$HOME/Sofware/ruby/bin
 1
 2
 3
 4
 5
 6
 方案一中主要是将GEM的安装路径进行修改，将GEM的默认安装路径修改成了$HOME/Software/ruby这个目录，然后再进行安装，最后将安装路径添加到PATH下，这样可以不用带完整的路径进行运行命令。
 
 方案二：
 
 $ gem install cocoapods -n ~/Software/ruby
 1
 方案二中使用了gem的自带参数-n—–即指明安装的路径，如果要使用这种的话，也需要将该路径加入PATH下才可以不用带完整的路径进行运行命令。
 
 个人建议是使用第一种，将GEM的安装路径进行修改。这样不需要每次都用-n命令进行指定路径。
 
 
 
 7.续
 //****************************************************
        在10.11系统中出现问题：While executing gem ... (Errno::EPERM) Operation not permitted - /usr/bin/pod
        解决：sudo gem install -n /usr/local/bin cocoapods
 
 //****************************************************
 
 8.例
pod ‘AFNetworking’      //不显式指定依赖库版本，表示每次都获取最新版本
pod ‘AFNetworking’,  ‘2.0’     //只使用2.0版本
pod ‘AFNetworking’, ‘>2.0′     //使用高于2.0的版本
pod ‘AFNetworking’, ‘>=2.0′     //使用大于或等于2.0的版本
pod ‘AFNetworking’, ‘<2.0′     //使用小于2.0的版本
pod ‘AFNetworking’, ‘<=2.0′     //使用小于或等于2.0的版本
pod ‘AFNetworking’, ‘~>0.1.2′     //使用大于等于0.1.2但小于0.2的版本，相当于>=0.1.2并且<0.2.0
pod ‘AFNetworking’, ‘~>0.1′     //使用大于等于0.1但小于1.0的版本
pod ‘AFNetworking’, ‘~>0′     //高于0的版本，写这个限制和什么都不写是一个效果，都表示使用最新版本


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    2015-12-29 多云转晴 --yim4ever
 
 */
