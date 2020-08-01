package com.fh.util.express;



/**
 * 定时任务控制
 *
 * @author liming
 */
public class TimerManager {


    public TimerManager() {

/*		// 添加每日0点释放静态奖金任务
		String dayTime = "0 0 0 * * ?";
		QuartzManager.addJob(Const.TIMED_TASK_STATIC, StaticBonusTaskJob.class, dayTime);

		// 隔4分钟查一次区块链余额并增加到用户钱包
		String inTime = "0 /4 * * * ? *";
		QuartzManager.addJob("TimingQuery_In", CheckingInTaskJob.class, inTime);

		// 从8分钟后开始，隔4分钟查一次区块链余额并减少用户钱包
		String outTiam = "0 8/4 * * * ? *";
		QuartzManager.addJob("TimingQuery_Out", CheckingOutTaskJob.class, outTiam);

        // 从0小时开始，隔3小时检查一次用户状态
        String userCheckTiam = "0 * 0/3 * * ? *";
        QuartzManager.addJob("userStatusCheck", UserStatusTask.class, userCheckTiam);

        // 默认隔5分钟查询发放一次跑单收益
        String minute = "5";
        String minutrCrom = "0 0/" + minute + " * * * ? *";
        QuartzManager.addJob(Const.INVEST_BONUS_TASK, InvestBonusTask.class, minutrCrom);
*/
    }


}
