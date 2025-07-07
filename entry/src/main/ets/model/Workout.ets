export interface Workout {
  id: number;
  name: string;
  weight: number;
  reps: number;
  target: number;
  done: number;
  date: string;       // yyyy-MM-dd
}

export interface WorkoutSet {
  workoutId: number;
  setNo: number;
  completedAt: number;   // epoch
}
