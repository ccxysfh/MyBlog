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

    <div class="post">
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
  </div>
  </div>
</template>

<script>
import echarts from 'echarts/lib/echarts';
import 'echarts/lib/chart/map'



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
    }, 500);
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
          self.blogpost = res.blogpost
          console.log(self.blogpost)
        })
    },
    load_chart(){
        console.log('load_chart');
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
