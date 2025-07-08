// entry/src/main/ets/App.ets
import TodayPage from './pages/TodayPage';
import HistoryPage from './pages/HistoryPage';
import StatsPage from './pages/StatsPage';
import SettingsPage from './pages/SettingsPage';

@Entry
@Component
struct App {
  @State tab: number = 0         // 0:今日 1:历史 2:统计 3:设置

  build() {
    // ===== 根容器：只能有一个 =====
    Column() {
      // ---------- 内容区域 ----------
      Navigator() {
        if (this.tab === 0) {
          TodayPage();
        } else if (this.tab === 1) {
          HistoryPage();
        } else if (this.tab === 2) {
          StatsPage();
        } else {
          SettingsPage();
        }
      }

      // ---------- 底部 Tab ----------
      Row() {
        this.TabItem('今日', 0);
        this.TabItem('历史', 1);
        this.TabItem('统计', 2);
        this.TabItem('设置', 3);
      }
      .justifyContent(FlexAlign.SpaceAround)
      .height(56)
      .backgroundColor('#18181815')
      .borderRadius(28)
      .margin({ bottom: 8 });
    }
    // ⬆️ 属性链必须写在 “}” 之后！
    .width('100%')
    .height('100%')
    .backgroundColor('#fefefe');
  }

  // -------- TabItem 必须用 @Builder ----------
  @Builder
  private TabItem(label: string, index: number) {
    Column() {                       // ① 先写组件体
      Text(label)
        .fontSize(14)
        .fontColor(this.tab === index ? '#FF5E21' : '#8E8E93');
    }
    .alignItems(HorizontalAlign.Center)   // ② 组件体结束后再链式
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width(60)
    .onClick(() => (this.tab = index));
  }
}
