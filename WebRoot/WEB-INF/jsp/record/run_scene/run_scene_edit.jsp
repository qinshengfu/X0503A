<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>

	<link rel="stylesheet" href="static/js/layui/css/layui.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">

					<form action="run_scene/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="RUN_SCENE_ID" id="RUN_SCENE_ID" value="${pd.RUN_SCENE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">第几场:</td>
								<td><input type="number" name="SCENE" id="SCENE" value="${pd.SCENE}" maxlength="300" placeholder="这里输入第几场" title="第几场" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">下期截止时间:</td>
								<td>
									<div class="layui-inline">
										<div class="layui-input-inline">
											<input type="text" name="NEXT_PERIOD" id="NEXT_PERIOD" value="${pd.NEXT_PERIOD}" class="layui-input" placeholder="yyyy-MM-dd HH:mm:ss">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字1:</td>
								<td><input type="number" name="NUM1" id="NUM1" value="${pd.NUM1}" maxlength="32" placeholder="这里输入数字1" title="数字1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字2:</td>
								<td><input type="number" name="NUM2" id="NUM2" value="${pd.NUM2}" maxlength="32" placeholder="这里输入数字2" title="数字2" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字3:</td>
								<td><input type="number" name="NUM3" id="NUM3" value="${pd.NUM3}" maxlength="32" placeholder="这里输入数字3" title="数字3" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字4:</td>
								<td><input type="number" name="NUM4" id="NUM4" value="${pd.NUM4}" maxlength="32" placeholder="这里输入数字4" title="数字4" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字5:</td>
								<td><input type="number" name="NUM5" id="NUM5" value="${pd.NUM5}" maxlength="32" placeholder="这里输入数字5" title="数字5" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字6:</td>
								<td><input type="number" name="NUM6" id="NUM6" value="${pd.NUM6}" maxlength="32" placeholder="这里输入数字6" title="数字6" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数字7:</td>
								<td><input type="number" name="NUM7" id="NUM7" value="${pd.NUM7}" maxlength="32" placeholder="这里输入数字7" title="数字7" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>

	<script type="text/javascript" src="static/js/layui/layui.all.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#SCENE").val()==""){
				$("#SCENE").tips({
					side:3,
		            msg:'请输入第几场',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SCENE").focus();
			return false;
			}
			if($("#NEXT_PERIOD").val()==""){
				$("#NEXT_PERIOD").tips({
					side:3,
		            msg:'请输入下期截止时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NEXT_PERIOD").focus();
			return false;
			}
			if($("#NUM1").val()==""){
				$("#NUM1").tips({
					side:3,
		            msg:'请输入数字1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM1").focus();
			return false;
			}
			if($("#NUM2").val()==""){
				$("#NUM2").tips({
					side:3,
		            msg:'请输入数字2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM2").focus();
			return false;
			}
			if($("#NUM3").val()==""){
				$("#NUM3").tips({
					side:3,
		            msg:'请输入数字3',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM3").focus();
			return false;
			}
			if($("#NUM4").val()==""){
				$("#NUM4").tips({
					side:3,
		            msg:'请输入数字4',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM4").focus();
			return false;
			}
			if($("#NUM5").val()==""){
				$("#NUM5").tips({
					side:3,
		            msg:'请输入数字5',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM5").focus();
			return false;
			}
			if($("#NUM6").val()==""){
				$("#NUM6").tips({
					side:3,
		            msg:'请输入数字6',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM6").focus();
			return false;
			}
			if($("#NUM7").val()==""){
				$("#NUM7").tips({
					side:3,
		            msg:'请输入数字7',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUM7").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		layui.use('laydate', function(){
			var laydate = layui.laydate;

			//日期时间选择器
			laydate.render({
				elem: '#NEXT_PERIOD'
				,type: 'datetime'
			});
		});
		</script>
</body>
</html>