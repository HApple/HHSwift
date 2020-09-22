[安装CocoaPods](https://cocoapods.org)

```shell
sudo gem update --system
sudo gem install cocoapods
```



[清华CocoaPods 镜像](https://mirrors.tuna.tsinghua.edu.cn/help/CocoaPods/)

新版的 CocoaPods 不允许用`pod repo add`直接添加master库了，但是依然可以：

```shell
$ cd ~/.cocoapods/repos 
$ pod repo remove master
$ git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git master
```

最后进入自己的工程，在自己工程的`podFile`第一行加上：

```shell
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
```



升级 cocoapods到最新版本

```shell
sudo gem install -n /usr/local/bin cocoapods 
```



[Podfile 使用方法](https://guides.cocoapods.org/using/the-podfile.html)

[SwiftJson](https://github.com/SwiftyJSON/SwiftyJSON#swiftyjson-model-generator)



[SwipeCellKit]( https://github.com/SwipeCellKit/SwipeCellKit)

[DefaultsKit](https://github.com/nmdias/DefaultsKit)

[加载 GIF](https://github.com/kaishin/Gifu)