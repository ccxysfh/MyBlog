function getEcharts(div_id, map_type, geoCoordForSpecialMap, baseMarkLine, baseMarkPoint, markLine, markPoint){
    // Step:3 conifg ECharts's path, link to echarts.js from current page.
    // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
    require.config({
        paths: {
            echarts: "/static/css3template_blog/echarts"
        }
    });

    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
            'echarts',
            'echarts/chart/map'
        ],
        function (ec) {
            // --- 地图 ---
            var myChart2 = ec.init(document.getElementById(div_id));

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
	});
}