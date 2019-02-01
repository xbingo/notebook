# 使用gitbook写周报
## 安装

1. 安装gitbook命令行
``` bash
npm install gitbook-cli -g
```
2. fork 项目我的周报代码 [https://git.code.oa.com/rubinxie/wikibook](https://git.code.oa.com/rubinxie/wikibook)并clone到本地

3. 进入wikibook目录，安装依赖：
```
gitbook install
```

4. 在本地试试效果：
```
gitbook serve
```
如果一切顺利，可以在 http://localhost:4000 看到静态页面。

## 配置
### 配置webhook

    进入一个 git 仓库的主页
    Settings => Advanced Settings => Web Hooks
    Url 中输入 http://pages.oa.com/webhook
    确保 Push Events 是勾选中的
    点击 Add Web Hook

### 修改CNAME
项目根目录的CNAME文件内的域名修改成自己的新域名，因为oa pages使用同一个域名无法发布，并且删除原有域名比较麻烦，可以使用例如 rubinxie2.pages.oa.com这样的域名

### 修改标题
项目根目录book.json文件中把title改成自己的

## 写作流程
### 在目录添加文章
打开`scr/SUMMARY.md`，这就是我们用来生成的文档左边目录栏的文件。目录结构通过列表加链接的形式来写，可以按照自己的需求组织目录结构。这里需要注意的是，由于目录折叠插件的限制，一个目录必须有一个对应的页面（哪怕是空的），否则目录无法展开。
### 写文章
在`SUMMARY.md`中添加好目录项，新建对应的.md文件，在md中用markdonw写文章
### 预览
运行
```
gitbook serve
```
通过浏览 http://localhost:4000 可以预览修改效果。
### 发表
在项目根目录执行
```
./publish.sh -m '提交信息'
```

## 使用技巧
gitbook除了支持标准markdown之外，还可以通过插件的形式支持更多特性。可以去[插件官网](https://plugins.gitbook.com/)上找找自己需要的插件。这里简单介绍几种由插件支持的特性的使用方法。

### 文字加底色
使用了`emphasize`插件，示例：
```
This text is {% em %}highlighted !{% endem %}

This text is {% em %}highlighted with **markdown**!{% endem %}

This text is {% em type="green" %}highlighted in green!{% endem %}

This text is {% em type="red" %}highlighted in red!{% endem %}

This text is {% em color="#ff0000" %}highlighted with a custom color!{% endem %}
```
效果如下：
This text is {% em %}highlighted !{% endem %}

This text is {% em %}highlighted with **markdown**!{% endem %}

This text is {% em type="green" %}highlighted in green!{% endem %}

This text is {% em type="red" %}highlighted in red!{% endem %}

This text is {% em color="#ff0000" %}highlighted with a custom color!{% endem %}

### 数学公式
使用了`katex`插件，示例：
```
Inline math: $$\int_{-\infty}^\infty g(x) dx$$


Block math:

$$
\int_{-\infty}^\infty g(x) dx
$$

Or using the templating syntax:

{% math %}\int_{-\infty}^\infty g(x) dx{% endblock %}
```
效果如下：
Inline math: $$\int_{-\infty}^\infty g(x) dx$$


Block math:

$$
\int_{-\infty}^\infty g(x) dx
$$

### 图表
使用了`mermaid-gb3`插件，mermaid的语法介绍可以查看：
[流程图](https://mermaidjs.github.io/flowchart.html)
[时序图](https://mermaidjs.github.io/sequenceDiagram.html)
[甘特图](https://mermaidjs.github.io/gantt.html)
示例：
```mermaid
graph TD;
A-->B;
A-->C;
B-->D;
C-->D;
```

### UML
使用'puml'插件，利用[PlantUml](http://plantuml.com/)来绘制UML图。
例如：
```
{% plantuml %}
Class Stage
    Class Timeout {
        +constructor:function(cfg)
        +timeout:function(ctx)
        +overdue:function(ctx)
        +stage: Stage
    }
    Stage <|-- Timeout
{% endplantuml %}
```
显示效果如下：

{% plantuml %}
Class Stage
    Class Timeout {
        +constructor:function(cfg)
        +timeout:function(ctx)
        +overdue:function(ctx)
        +stage: Stage
    }
    Stage <|-- Timeout
{% endplantuml %}

### 绘制函数图像
使用了`graph`插件，利用[function-plot](https://mauriciopoppe.github.io/function-plot/)绘制数学函数图。

下面是一个示例，需要注意的是 `{% graph %}` 块中的内容必须是合法的 JSON 格式。
```
{% graph %}
{
    "title": "1/x * cos(1/x)",
    "grid": true,
    "xAxis": {
        "domain": [0.01, 1]
    },
    "yAxis": {
        "domain": [-100, 100]
    },
    "data": [{
        "fn": "1/x * cos(1/x)",
        "closed": true
    }]
}
{% endgraph %}
```

效果如下所示：

{% graph %}
{
    "title": "1/x * cos(1/x)",
    "grid": true,
    "xAxis": {
        "domain": [0.01, 1]
    },
    "yAxis": {
        "domain": [-100, 100]
    },
    "data": [{
        "fn": "1/x * cos(1/x)",
        "closed": true
    }]
}
{% endgraph %}

### 统计图
使用`chart`插件，用 C3.js 或者 Highcharts 绘制图形。

[插件地址](https://plugins.gitbook.com/plugin/chart)  
[C3.js](https://github.com/c3js/c3)  
[highcharts](https://github.com/highcharts/highcharts)

下面是一个示例：
```
{% chart %}
{
    "data": {
        "type": "bar",
        "columns": [
            ["data1", 30, 200, 100, 400, 150, 250],
            ["data2", 50, 20, 10, 40, 15, 25]
        ],
        "axes": {
            "data2": "y2"
        }
    },
    "axis": {
        "y2": {
            "show": true
        }
    }
}
{% endchart %}
```
效果如下所示：
{% chart %}
{
    "data": {
        "type": "bar",
        "columns": [
            ["data1", 30, 200, 100, 400, 150, 250],
            ["data2", 50, 20, 10, 40, 15, 25]
        ],
        "axes": {
            "data2": "y2"
        }
    },
    "axis": {
        "y2": {
            "show": true
        }
    }
}
{% endchart %}

### 页面内目录
在需要生成目录的地方加上 
```
<!-- toc -->
```
另外，`Anchor-navigation-ex`插件会自动在页面右侧生成一个悬浮导航栏

### todo
使用示例：
```
- [ ] write some articles
- [x] drink a cup of tea
```
显示效果：

- [ ] write some articles
- [x] drink a cup of tea

### 展示csv文件
使用示例：
```
{% includeCsv  src="./assets/csv/test.csv", useHeader="true" %} {% endincludeCsv %}
```
效果如下所示：

{% includeCsv  src="./assets/csv/test.csv", useHeader="true" %} {% endincludeCsv %}