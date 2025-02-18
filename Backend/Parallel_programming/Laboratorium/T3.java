public class T3 extends Thread {
    private final Monitor monitor;
    private final int start;
    private final int end;
    public T3(Monitor monitor) {
        start = Data.N / 2;
        end = Data.N / 4 * 3;
        this.monitor = monitor;
    }
    @Override
    public void run() {
        System.out.println("Start Thread 3");
        // Очікування закінчення введення даних в T2, T4
        monitor.wait_input();
        // КД1
        int a3 = 1;
        monitor.set_a(a3);
        // Сигнал задачам T1, T2, T4 про обчислення 2)
        monitor.signal_calc();
        // Очікування сигналів Т1, Т2, Т4 про обчислення
        monitor.wait_calc();

        a3 = monitor.get_a(); // КД 2
        int d3 = monitor.get_d(); // КД3
        int[][] MX3 = Data.fixMatrixLength(Data.MX, start, end);
        // Обчислення 3)
        int[] F3 = Data.addArrays(Data.mulScalArray(d3, Data.fixArrayLength(Data.B, start, end)),
                Data.mulArrayMatrix(Data.fixArrayLength(Data.Z, start, end), Data.mulMatrix(Data.MM, MX3)));
        // Обчислення 4)
        Data.Lh3 = Data.Sort(F3);
        // Очікування закінчення обчислення 4) в задачі Т4
        monitor.wait_sort2();
        // Обчислення 5) K2H = sort(LH, LH)
        Data.Lh2_2 = Data.sortTwoVecs(Data.Lh3, Data.Lh4);
        // Сигнал задачі T1 про обчислення 5)
        monitor.signal_sort3();
        // Сигнал про обчислення 6) у Т1
        monitor.wait_sort4();
        // Обчислення 7) XH = LH * a
        Data.insertArrayRes(Data.mulScalArray(a3, Data.X), Data.X, start, end);
        // Сигнал 4 про завершення обчислення 7)
        monitor.signal_finish();
        
        System.out.println("Thread 3 has completed.");
    }

}