public class T2 extends Thread {
    private final Monitor monitor;
    private final int start;
    private final int end;
    public T2(Monitor monitor) {
        Data.B = new int[Data.N];
        Data.MX = new int[Data.N][Data.N];
        start = Data.N / 4;
        end = Data.N / 2;
        this.monitor = monitor;
    }
    @Override
    public void run() {
        System.out.println("Start Thread 2");
        for (int i = 0; i < Data.N; i++) { // Введення В, МХ
            Data.B[i] = 1;
            for (int j = 0; j < Data.N; j++){
                Data.MX[i][j] = 1;
            }
        }
        // Сигнал T4 про введення даних
        monitor.input_signal();
        // Очікування закінчення введення даних в Т4
        monitor.wait_input();
        // КД1
        int a2 = 1;
        monitor.set_a(a2);
        // Сигнал задачам T1, T3, T4 про обчислення 2)
        monitor.signal_calc();
        // Очікування сигналів Т1, Т3, Т4 про обчислення
        monitor.wait_calc();

        a2 = monitor.get_a(); // КД2
        int d2 = monitor.get_d(); // КД3
        int[][] MX2 = Data.fixMatrixLength(Data.MX, start, end);
        // Обчислення 3)
        int[] F2 = Data.addArrays(Data.mulScalArray(d2, Data.fixArrayLength(Data.B, start, end)),
                Data.mulArrayMatrix(Data.fixArrayLength(Data.Z, start, end), Data.mulMatrix(Data.MM, MX2)));
        // Обчислення 4)
        Data.Lh2 = Data.Sort(F2);
        // Сигнал задачі T1 про завершення обчислення 4)
        monitor.signal_sort1();
        // Очікування на сигнал про обчислення 6) у Т1
        monitor.wait_sort4();
        // Обчислення 7) XH = LH * a
        Data.insertArrayRes(Data.mulScalArray(a2, Data.X), Data.X, start, end);
        // Сигнал 4 про завершення обчислення 7)
        monitor.signal_finish();

        System.out.println("Thread 2 has completed.");
    }
}