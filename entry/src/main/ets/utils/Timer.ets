@Component
export function RestTimer(seconds: number,
  finish: (done: boolean) => void) {
  @State left = seconds;

  setInterval(() => {
    left--;
    if (left <= 0) {
      finish(true);
      clearInterval();
    }
  }, 1000);

  Column({ width: '80%', height: '30%' })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(24) {
    Text(left.toString())
      .fontSize(48).fontWeight(600);
    Text('秒后开始下一组').margin({ top: 8 });
  }
}
