<template>

  <div>
    <header id="blog-header">
      <div class="inner ">
        <nav id="navigation">
          <span class="blog-logo">
          </span>
        </nav>
      </div>
    </header>

    <article class="post">
    <div class="inner">
      <p class="meta">
        <time :pubdate="blogpost.fields.pub_date" :data-updated="blogpost.fields.last_edit_date" v-text="$options.filters.date(blogpost.fields.pub_date, '%b') +' '+$options.filters.date(blogpost.fields.pub_date, '%d')+ ','+ $options.filters.date(blogpost.fields.pub_date, '%Y') ">
        </time>
      </p>
      <header class="post-header">
        <h2 class="post-title">生日快乐</h2>
         <h2 class="page-description">致胡瑶</h2>
        <div class="clear"></div>
      </header>
      <p>印象中，这一年你去过了很多地方，看到了很多不一样的风景，新的一年成为更好的自己。</p>
      <div id="jiangxiMap" style="height:400px;width: 100%;padding:10px;background:#1B1B1B"></div>
      <p>这一年，我去了泰安，青岛和天津，但是去到哪都不像是旅行，因为很早就想和你一起去旅行，但终究都是一个人。</p>
      <p>想和你一起去旅行，去哈尔滨看冰雕大教堂，去爬泰山看日出，去青岛看海吃螃蟹，去成都看大熊猫吃火锅，去拉萨看布达拉宫，去上海看看黄浦江的夜景，去昆明吃云南的过桥米线，去大理看苍山洱海，去厦门看你曾经看过的风景。</p>
      <p>我还能这么想，是因为我能感受到你的沉静，你的心和我一样沉静，这是我时常感觉幸运的。</p>
      <div id="mainMap" style="height:400px;width:100%;padding:10px;background:#1B1B1B"></div>
      <div class="post-excerpt">
        <span v-html="blogpost.content"></span>
      </div>
      <footer class="post-meta">
        <img class="author-thumb" src="../assets/images/ccx.jpeg" alt="Changxin Cheng" nopin="nopin" />
        <router-link :to="{ name: 'profile'}">Changxin Cheng</router-link>
        posted
        <time class="post-date" :pubdate="blogpost.fields.pub_date" :data-updated="blogpost.fields.last_edit_date" v-text="$options.filters.date(blogpost.fields.pub_date, '%b') +' '+$options.filters.date(blogpost.fields.pub_date, '%d')+ ','+ $options.filters.date(blogpost.fields.pub_date, '%Y') ">
        </time>
      </footer>
    </div>
  </article>
  </div>
</template>

<script>
import echarts from 'echarts/lib/echarts';
import 'echarts/lib/chart/map'
import china from 'echarts/map/js/china'



export default {
  name: 'birthday',
  components: {
  },
  data() {
    return {
      blogpost: null
    }
  },
  computed: {},
  beforeCreate() {

  },
  created() {
    this.getBlogPost()
  },
  mounted() {
    this.$nextTick(function () {
      this.load_chart()
    });
  },
  watch: {
    blogpost: function() {
      var self = this
      console.log('blogpost changed');
      setTimeout(function() {
        $('#document').ready(function(){
            self.load_chart();
        });
    }, 3000);
    }
  },
  methods: {
    async getBlogPost() {
      let url = '/blog/api/happy_birthday_to_my_princess_huyao'
      let reqUrl = this.$store.state.baseUrl + url
      console.log(reqUrl)
      let self = this
      await this.$http.get(reqUrl)
        .then((response) => {
          var res = JSON.parse(response.bodyText)
          self.blogpost = res.blogpost;
          console.log(self.blogpost)
        })
    },
    load_chart(){
        console.log('load_chart');
        var baseMarkPoint=[
    {name:'上海',value:60},
    {name:'南昌',value:100},
    {name:'北京',value:10},
    {name:'青岛',value:60},
    {name:'拉萨',value:60},
    {name:'成都',value:60},
    {name:'泰安',value:60},
    {name:'厦门',value:60},
    {name:'大理',value:60},
//    {name:'丽江',value:60},
    {name:'昆明',value:60},
    {name:'哈尔滨',value:60},
]
        var baseMarkLine=[]
        var markPoint=[
        //								{name:'上海',value:95},
        //								{name:'广州',value:90},
        //								{name:'大连',value:80},
        //								{name:'南宁',value:70},
        //								{name:'南昌',value:60},
        //								{name:'拉萨',value:50},
        //								{name:'长春',value:40},
        //								{name:'包头',value:30},
        //								{name:'重庆',value:20},
        //								{name:'常州',value:10}
                      ];
        var markLine=[
            [{name:'北京'}, {name:'南昌',value:60}],
            [{name:'北京'}, {name:'上海',value:20}],
            [{name:'南昌'}, {name:'上海',value:100}],
            [{name:'北京'}, {name:'拉萨',value:20}],
            [{name:'南昌'}, {name:'拉萨',value:100}],
            [{name:'北京'}, {name:'青岛',value:20}],
            [{name:'南昌'}, {name:'青岛',value:100}],
            [{name:'北京'}, {name:'厦门',value:20}],
            [{name:'南昌'}, {name:'厦门',value:100}],
            [{name:'北京'}, {name:'成都',value:20}],
            [{name:'南昌'}, {name:'成都',value:100}],
            [{name:'北京'}, {name:'泰安',value:20}],
            [{name:'南昌'}, {name:'泰安',value:100}],
            [{name:'北京'}, {name:'大理',value:20}],
            [{name:'南昌'}, {name:'大理',value:100}],
            [{name:'北京'}, {name:'哈尔滨',value:20}],
            [{name:'南昌'}, {name:'哈尔滨',value:100}],
        //    [{name:'北京'}, {name:'丽江',value:20}],
        //    [{name:'南昌'}, {name:'丽江',value:100}],
            [{name:'北京'}, {name:'昆明',value:20}],
            [{name:'南昌'}, {name:'昆明',value:100}],
        //								[{name:'拉萨'}, {name:'南昌',value:50}],
        //								[{name:'长春'}, {name:'南昌',value:40}],
        //								[{name:'包头'}, {name:'南昌',value:30}],
        //								[{name:'重庆'}, {name:'南昌',value:20}],
        //								[{name:'常州'}, {name:'南昌',value:10}]
                      ];
        var china_geoCoordForSpecialMap = {
                      '上海': [121.4648,31.2891],
                      '东莞': [113.8953,22.901],
                      '东营': [118.7073,37.5513],
                      '中山': [113.4229,22.478],
                      '临汾': [111.4783,36.1615],
                      '临沂': [118.3118,35.2936],
                      '丹东': [124.541,40.4242],
                      '丽水': [119.5642,28.1854],
                      '乌鲁木齐': [87.9236,43.5883],
                      '佛山': [112.8955,23.1097],
                      '保定': [115.0488,39.0948],
                      '兰州': [103.5901,36.3043],
                      '包头': [110.3467,41.4899],
                      '北京': [116.4551,40.2539],
                      '北海': [109.314,21.6211],
                      '南京': [118.8062,31.9208],
                      '南宁': [108.479,23.1152],
                      '南昌': [116.0046,28.6633],
                      '南通': [121.1023,32.1625],
                      '厦门': [118.1689,24.6478],
                      '台州': [121.1353,28.6688],
                      '合肥': [117.29,32.0581],
                      '呼和浩特': [111.4124,40.4901],
                      '咸阳': [108.4131,34.8706],
                      '哈尔滨': [127.9688,45.368],
                      '唐山': [118.4766,39.6826],
                      '嘉兴': [120.9155,30.6354],
                      '大同': [113.7854,39.8035],
                      '大连': [122.2229,39.4409],
                      '天津': [117.4219,39.4189],
                      '太原': [112.3352,37.9413],
                      '威海': [121.9482,37.1393],
                      '宁波': [121.5967,29.6466],
                      '宝鸡': [107.1826,34.3433],
                      '宿迁': [118.5535,33.7775],
                      '常州': [119.4543,31.5582],
                      '广州': [113.5107,23.2196],
                      '廊坊': [116.521,39.0509],
                      '延安': [109.1052,36.4252],
                      '张家口': [115.1477,40.8527],
                      '徐州': [117.5208,34.3268],
                      '德州': [116.6858,37.2107],
                      '惠州': [114.6204,23.1647],
                      '成都': [103.9526,30.7617],
                      '扬州': [119.4653,32.8162],
                      '承德': [117.5757,41.4075],
                      '拉萨': [91.1865,30.1465],
                      '无锡': [120.3442,31.5527],
                      '日照': [119.2786,35.5023],
                      '昆明': [102.9199,25.4663],
                      '杭州': [119.5313,29.8773],
                      '枣庄': [117.323,34.8926],
                      '柳州': [109.3799,24.9774],
                      '株洲': [113.5327,27.0319],
                      '武汉': [114.3896,30.6628],
                      '汕头': [117.1692,23.3405],
                      '江门': [112.6318,22.1484],
                      '沈阳': [123.1238,42.1216],
                      '沧州': [116.8286,38.2104],
                      '河源': [114.917,23.9722],
                      '泉州': [118.3228,25.1147],
                      '泰安': [117.0264,36.0516],
                      '泰州': [120.0586,32.5525],
                      '济南': [117.1582,36.8701],
                      '济宁': [116.8286,35.3375],
                      '海口': [110.3893,19.8516],
                      '淄博': [118.0371,36.6064],
                      '淮安': [118.927,33.4039],
                      '深圳': [114.5435,22.5439],
                      '清远': [112.9175,24.3292],
                      '温州': [120.498,27.8119],
                      '渭南': [109.7864,35.0299],
                      '湖州': [119.8608,30.7782],
                      '湘潭': [112.5439,27.7075],
                      '滨州': [117.8174,37.4963],
                      '潍坊': [119.0918,36.524],
                      '烟台': [120.7397,37.5128],
                      '玉溪': [101.9312,23.8898],
                      '珠海': [113.7305,22.1155],
                      '盐城': [120.2234,33.5577],
                      '盘锦': [121.9482,41.0449],
                      '石家庄': [114.4995,38.1006],
                      '福州': [119.4543,25.9222],
                      '秦皇岛': [119.2126,40.0232],
                      '绍兴': [120.564,29.7565],
                      '聊城': [115.9167,36.4032],
                      '肇庆': [112.1265,23.5822],
                      '舟山': [122.2559,30.2234],
                      '苏州': [120.6519,31.3989],
                      '莱芜': [117.6526,36.2714],
                      '菏泽': [115.6201,35.2057],
                      '营口': [122.4316,40.4297],
                      '葫芦岛': [120.1575,40.578],
                      '衡水': [115.8838,37.7161],
                      '衢州': [118.6853,28.8666],
                      '西宁': [101.4038,36.8207],
                      '西安': [109.1162,34.2004],
                      '贵阳': [106.6992,26.7682],
                      '连云港': [119.1248,34.552],
                      '邢台': [114.8071,37.2821],
                      '邯郸': [114.4775,36.535],
                      '郑州': [113.4668,34.6234],
                      '鄂尔多斯': [108.9734,39.2487],
                      '重庆': [107.7539,30.1904],
                      '金华': [120.0037,29.1028],
                      '铜川': [109.0393,35.1947],
                      '银川': [106.3586,38.1775],
                      '镇江': [119.4763,31.9702],
                      '长春': [125.8154,44.2584],
                      '长沙': [113.0823,28.2568],
                      '长治': [112.8625,36.4746],
                      '阳泉': [113.4778,38.0951],
                      '青岛': [120.4651,36.3373],
                      '韶关': [113.7964,24.7028],
                                    "大理":[99.9536,25.6805],
                                    "丽江市":[99.448,23.955],
                                    "西双版纳":[100.8984,21.8628],
                    };
        var map_type ="china";
        var div_id = "mainMap";
        this.get_charts(div_id, map_type, china_geoCoordForSpecialMap, baseMarkLine,  baseMarkPoint, markLine, markPoint)
    },
    get_charts(div_id, map_type, geoCoordForSpecialMap, baseMarkLine, baseMarkPoint, markLine, markPoint){
      // echarts.registerMap("china",china);

      var myChart2 = echarts.init(document.getElementById(div_id));
      let loadMap = (param) => {
        myChart2.setOption({
          geo: {map: param}
        })
      };
      loadMap(map_type);
      myChart2.setOption({
				dataRange: {
					min : 0,
					max : 100,
					calculable : false,
					color: ['#ff3333', 'orange', 'yellow','lime','aqua'],
					textStyle:{
						color:'#fff'
					},
					show:false,
				},
				series : [
					{
						name: '全国',
						type: 'map',
						roam: false,
						hoverable: false,
						mapType: map_type,
						itemStyle:{
							normal:{
								borderColor:'rgba(100,149,237,1)',
								borderWidth:0.5,
								areaStyle:{
									color: '#1b1b1b'
								}
							}
						},
						data:[],
						markLine : {
							smooth:true,
							symbol: ['none', 'circle'],
							symbolSize : 1,
							itemStyle : {
								normal: {
									color:'#fff',
									borderWidth:1,
									borderColor:'rgba(30,144,255,0.5)'
								}
							},
							data : baseMarkLine,
						},
						geoCoord: geoCoordForSpecialMap,
						markPoint : {
							symbol:'emptyCircle',
							symbolSize : function (v){
								return 10 + v/10
							},
							effect : {
								show: true,
								shadowBlur : 0
							},
							itemStyle:{
								normal:{
									label:{show:false}
								},
								emphasis: {
									label:{position:'top'}
								}
							},
							data : baseMarkPoint
						}
					},
					{
						name: 'Top10',
						type: 'map',
						mapType: map_type,
						data:[],
						markLine : {
							smooth:true,
							effect : {
								show: true,
								scaleSize: 1,
								period: 30,
								color: '#fff',
								shadowBlur: 10
							},
							itemStyle : {
								normal: {
									label:{show:false},
									borderWidth:1,
									lineStyle: {
										type: 'solid',
										shadowBlur: 10
									}
								}
							},
							data : markLine
						},
						markPoint : {
							symbol:'emptyCircle',
							symbolSize : function (v){
								return 0.1
							},
							effect : {
								show: false,
								shadowBlur : 0
							},
							itemStyle:{
								normal:{
									label:{show:true,
										  position:'top',
										  textStyle: {
													fontSize: 14
												}
										  }
								},
								emphasis: {
									label:{show:false}
								}
							},
							data : markPoint
						}
					}
				]
        });
    },
    load_bar(){
       var chart_div = document.getElementById('mainMap')
        var myChart = echarts.init(chart_div);
        require('echarts/lib/chart/bar');
        // 引入提示框和标题组件
        require('echarts/lib/component/tooltip');
        require('echarts/lib/component/title');
        // 绘制图表
        myChart.setOption({
            title: {
                text: 'ECharts 入门示例'
            },
            tooltip: {},
            xAxis: {
                data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 10, 20]
            }]
        });
    }
  }
}
</script>

<style scoped>
  .codehilite code, tt {
    position: relative;
    margin: 0 0.334em;
    padding: 0.334em 0.667em;
    font-family: monospace, sans-serif;
    font-size: 1.2em;
    white-space: pre;
    background: #faf9f7;
    border: 1px solid #e5e4e1;
    top: -2px
  }

  .author-thumb {
    width: 24px;
    height: 24px;
    float: left;
    margin: auto;
    padding: 3px;
    border-radius: 100%;
    margin-top: -5px;
  }

  .post-date {
    display: inline-block;
    margin-left: 8px;
    padding-left: 12px;
    border-left: #d5dbde 1px solid;
    text-transform: uppercase;
    font-size: 1.3rem;
    white-space: nowrap;
  }

  .post-title h2 {
  font-size: 2.0em;
  }

  .post-excerpt {
  font-size: 0.8em;
  }

  .container .post {
  padding: 1.5em 0;
  }

  .post-meta {
  margin: 1.334em 0;
  }
</style>
