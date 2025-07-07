import rdb from '@ohos.data.rdb';
import { Workout } from './Workout';

class Database {
  private helper: rdb.RdbStore | undefined;

  constructor() {
    this.init();
  }

  private async init() {
    const config: rdb.StoreConfig = {
      name: 'workout.db',
      encrypt: false,
      maxSize: 4 * 1024 * 1024,
      isMemoryRdb: false
    };
    this.helper = await rdb.getRdbStore(getContext(this), config);
    await this.helper.executeSql(`
      CREATE TABLE IF NOT EXISTS workout(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT, weight INTEGER, reps INTEGER,
        target INTEGER, done INTEGER, date TEXT
      );
    `);
  }

  // 读取今日训练
  queryToday(): Workout[] {
    const today = new Date().toISOString().slice(0, 10);
    const result = this.helper?.querySql(
      'SELECT * FROM workout WHERE date = ?', [today]);
    return result?.rows as unknown as Workout[] || [];
  }

  updateSet(id: number, done: number) {
    this.helper?.executeSql(
      'UPDATE workout SET done = ? WHERE id = ?', [done, id]);
  }
}
export const db = new Database();
