# YSGaussianView
高斯模糊视图，可以用在iOS7.0及以下版本。
使用范例：
```
// app即将进入后台，显示高斯模糊视图
- (void)applicationWillResignActive:(UIApplication *)application {
    [YSGaussianView show];
}

// app已经进入前台，隐藏高斯模糊视图
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [YSGaussianView dismiss];
}
```
