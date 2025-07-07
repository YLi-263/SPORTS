@Component
export default struct HistoryPage {
  build() {
    Column()
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center) {
      Text('历史页 TODO')
        .fontSize(20);
    }
  }
}
