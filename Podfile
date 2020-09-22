
# 用的是[清华CocoaPods 镜像](https://mirrors.tuna.tsinghua.edu.cn/help/CocoaPods/)
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

# 这里可以用自己的私有库
# source 'https://github.com/Artsy/Specs.git'

# 平台 系统
platform :ios, '10.0'
use_frameworks!

# 不提示警告
inhibit_all_warnings!

# [Podfile 使用方法](https://guides.cocoapods.org/using/the-podfile.html)


# 由于分了Beta Inhouse Store 三个 Target,使用 abstract_target
# If you want multiple targets to share the same pods, use an abstract_target.
# There are no targets called "HHSwift" in any Xcode projects
# 这句也可以省略 这里加上
abstract_target 'HHSwift' do
  
####### 这里放它们共有的库 #######
 
  ####### Swift 库 #######
  #解析 JSON
  pod 'SwiftyJSON', '~> 5.0.0'
    
  #网络库 5.0还在beta中（20200103）
  pod 'Alamofire', '~> 4.9.1'

  #数据库 5.0还在beta中（20200103）
  pod 'RealmSwift', '~> 4.3.0'
 
  #图片下载
  pod 'Kingfisher', '~> 5.12.0'

  #布局
  pod 'SnapKit', '~> 5.0.1'
  
  #键盘工具
  pod 'IQKeyboardManagerSwift', '~> 6.5.4'

  #各种加密算法
  pod 'CryptoSwift', '~> 1.3.0'
  
  pod 'KeychainAccess', '~> 4.1.0'
  
  #本地化工具
  pod 'Localize-Swift', '~> 3.1.0'
  
  #原生拓展库
  pod 'SwifterSwift', '~> 5.1.0'
  pod 'TimedSilver', '~> 1.2.0'
  
  #WebSocket
  # 有点坑 指定下最新版本
  pod 'SwiftWebSocket', :git => "https://github.com/tidwall/SwiftWebSocket.git", :tag => "v2.8.0"

  #日志框架
  pod 'XCGLogger', '~> 7.0.0'
  
  # UI -> Placeholder TextView
  pod 'KMPlaceholderTextView', '~> 1.4.0'
  
  
  
  ####### Swift 库 #######
  
  
  
  
  

  ####### oc 库  #######
  #下拉刷新
  pod 'MJRefresh', '~> 3.3.1'
  
  #加载提示框
  pod 'SVProgressHUD', '~> 2.2.5'
  
  ####### oc 库  #######

####### 这里放它们共有的库 #######








  target 'HHSwift_Beta' do
	  # 这里放它独享的库
  end

  target 'HHSwift_Inhouse' do
	 # 这里放它独享的库
  end

  target 'HHSwift_Store' do
	# 这里放它独享的库
  end
end
