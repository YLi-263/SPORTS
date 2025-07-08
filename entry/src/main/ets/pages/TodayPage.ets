// entry/src/main/ets/pages/TodayPage.ets
import { Workout } from '../model/Workout';
import { db } from '../model/Database';
import { RestTimer } from '../utils/Timer';

@Component
export default struct TodayPage {
  @State workouts: Workout[] = [];
  @State showTimer: boolean = false;
  @State secondsLeft: number = 0;

  aboutToAppear() {
    this.workouts = db.queryToday();       // 取当日计划
  }

  build() {
    Column({ width: '100%' }) {
      // 日期 + 完成度环形进度（示意）
      Text($r('app.string.today'))
        .fontSize(24).margin({ top: 16, bottom: 8 });

        ForEach(this.workouts, (item, index) => {
          this.Card(item, index);
        });

      // 组间倒计时弹窗
      if (this.showTimer) {
        RestTimer(this.secondsLeft, (done: boolean) => {
          this.showTimer = false;
        });
      }
    }
    .padding({ left: 16, right: 16 });
  }

  // 单个训练卡片
  @Builder
  private Card(w: Workout, i: number) {
    Column()
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: '#40000000' })
      .padding(16)
      .margin({ bottom: 12 }) {

      // 标题 + 进度提示
      Row({ justifyContent: FlexAlign.SpaceBetween }) {
        Text(`${w.name}  ${w.weight}kg`)
          .fontWeight(600)
          .fontSize(18);
        Text(`${w.done}/${w.target}`)
          .fontColor('#FF5E21');
      }

      // 进度条
      Progress({ value: w.done / w.target })
        .height(6).margin({ top: 8, bottom: 12 })
        .backgroundColor('#ECECEC')
        .color('#FF5E21');

      // 操作区
      Row({ justifyContent: FlexAlign.SpaceBetween }) {
        Button('+ 记录一组')
          .type(ButtonType.Capsule)
          .onClick(() => {
            w.done += 1;
            db.updateSet(w.id, w.done);
            if (w.done < w.target) {
              this.secondsLeft = 90;      // 默认 90s 倒计时
              this.showTimer = true;
            }
          });

        Text('目标：' + w.target + ' 组 × ' + w.reps + ' 次')
          .fontColor('#8E8E93');
      }
    }
  }
}
