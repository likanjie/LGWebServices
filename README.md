# LGWebServices
使用AFN封装soap请求WebServices数据

###使用一个手机号码查询来做一个例子示范webservices的使用

soap信息解读:下图的标注可根据实际开发更改，其它的不变(demo中已经把soap信息封装了一部分)
![soap信息解读](https://github.com/likanjie/image/blob/master/soap.png?raw=true)

##响应XML数据如下 我们需要的内容是<getMobileCodeInfoResult>和</getMobileCodeInfoResult>之间的内容，可通过XML解析得到我们想要的内容
```Objective-C
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <soap:Body>
        <getMobileCodeInfoResponse xmlns="http://WebXml.com.cn/">
            <getMobileCodeInfoResult>1234567890：广东 中山 广东移动全球通卡
            </getMobileCodeInfoResult>
        </getMobileCodeInfoResponse>
    </soap:Body>
</soap:Envelope>
```
具体看demo
