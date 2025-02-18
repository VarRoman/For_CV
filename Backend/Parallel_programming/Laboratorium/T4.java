public class T4 extends Thread {
    private final Monitor monitor;
    private final int start;
    private final int end;

    public T4(Monitor monitor) {
        Data.MM = new int[Data.N][Data.N];
        Data.Z = new int[Data.N];
        Data.X = new int[Data.N];
        start = Data.N / 4 * 3;
        end = Data.N;
        this.monitor = monitor;
    }
    @Override
    public void run(){
        System.out.println("Start Thread 4");
        for (int i = 0; i < Data.N; i++) { // Введення Z, MM, d
            Data.X[i] = 1;
            Data.Z[i] = 1;
            for (int j = 0; j < Data.N; j++){
                Data.MM[i][j] = 1;
            }
        }
        
        monitor.set_d(1);
        // Сигнал T2 про введення даних
        monitor.input_signal();
        // Очікування закінчення введення даних в Т4
        monitor.wait_input();
        // КД1
        int a4 = 1;
        monitor.set_a(a4);
        // Сигнал задачам T1, T2, T3 про обчислення 2)
        monitor.signal_calc();
        // Сигнал про обчислення 2) у задачах T1, T2, T3
        monitor.wait_calc();

        a4 = monitor.get_a(); // КД2
        int d4 = monitor.get_d(); // КД3
        int[][] MX4 = Data.fixMatrixLength(Data.MX, start, end);
        // Обчислення 3) 
        int[] F4 = Data.addArrays(Data.mulScalArray(d4, Data.fixArrayLength(Data.B, start, end)),
                Data.mulArrayMatrix(Data.fixArrayLength(Data.Z, start, end), Data.mulMatrix(Data.MM, MX4)));
        // Обчислення 4) 
        Data.Lh4 = Data.Sort(F4);
        // Сигнал задачі T3 про обчислення 4)
        monitor.signal_sort2();
        // Сигнал про обчислення 6) у Т1
        monitor.wait_sort4();
        // Обчислення 7) XH = LH * a
        Data.insertArrayRes(Data.mulScalArray(a4, Data.X), Data.X, start, end);
        // Чекати сигнали T1, T2, T3 про обчислення 7)
        monitor.wait_finish();
        // Виведення результату X
        if (Data.N == 4) {
            Data.printvec(Data.X);
        }

        System.out.println("Thread 4 has completed.");
    }
}