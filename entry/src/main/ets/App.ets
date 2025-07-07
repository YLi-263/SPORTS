// ---------- entry/src/main/ets/App.ets ----------
@Entry
@Component
struct App {
  @State tab: number = 0     // 0:今日 1:历史 2:统计 3:设置

  build() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('#fefefe') {

      // 页面区域
      Navigator() {
        if (this.tab === 0) TodayPage();
        else if (this.tab === 1) HistoryPage();
        else if (this.tab === 2) StatsPage();
        else SettingsPage();
      }

      // 底部胶囊 TabBar
      Row()
        .justifyContent(FlexAlign.SpaceAround)
        .height(56)
        .backgroundColor('#18181815')
        .borderRadius(28)
        .margin({ bottom: 8 }) {
        this.TabItem('今日', 0);
        this.TabItem('历史', 1);
        this.TabItem('统计', 2);
        this.TabItem('设置', 3);
      }
    }
  }

  @Builder
  private TabItem(label: string, index: number) {
    Column()
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width(60)
      .onClick(() => (this.tab = index)) {
      Text(label)
        .fontSize(14)
        .fontColor(this.tab === index ? '#FF5E21' : '#8E8E93');
    }
  }
}

// 页面导入
import TodayPage from './pages/TodayPage';
import HistoryPage from './pages/HistoryPage';
import StatsPage from './pages/StatsPage';
import SettingsPage from './pages/SettingsPage';
