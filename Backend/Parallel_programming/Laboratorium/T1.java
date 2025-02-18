public class T1 extends Thread {
    Monitor monitor;
    private final int start;
    private final int end;
    public T1(Monitor monitor) {
        
        start = 0;
        end = Data.N / 4;
        this.monitor = monitor;
    }

    @Override
    public void run(){
        System.out.println("Start Thread 1");
        
        // Очікування сигналів від Т2, Т4
        monitor.wait_input();
        
        // КД1
        int a1 = 1;
        monitor.set_a(a1);
        
        // Сигнал задачам T2, T3, T4 про обчислення 2)
        monitor.signal_calc();
        // Очікування сигналів Т2, Т3, Т4 про обчислення
        monitor.wait_calc();
        
        int d1 = monitor.get_d(); // КД2
        a1 = monitor.get_a(); // КД3
        int[][] MX1 = Data.fixMatrixLength(Data.MX, start, end);
        // Обчислення 3)
        int[] F1 = Data.addArrays(Data.mulScalArray(d1, Data.fixArrayLength(Data.B, start, end)),
                Data.mulArrayMatrix(Data.fixArrayLength(Data.Z, start, end), Data.mulMatrix(Data.MM, MX1)));
        
        Data.Lh1 = Data.Sort(F1); // Обчислення 4)
        // Очікування закінчення обчислення 4) в задачі Т2
        monitor.wait_sort1();
        // Обчислення 5) L2H = sort(LH, LH)
        Data.Lh2_1 = Data.sortTwoVecs(Data.Lh1, Data.Lh2);
        // Очікування закінчення обчислення 5 в Т3
        monitor.wait_sort3();
        // Обчислення 6) L = sort(L2H, L2H)
        Data.X = Data.sortTwoVecs(Data.Lh2_1, Data.Lh2_2);
        // Сигнал T2, T3, T4 задачам про обчислення 6)
        monitor.signal_sort4();
        //Обчислення 7) XH = LH * a
        Data.insertArrayRes(Data.mulScalArray(a1, Data.X), Data.X, start, end);
        // Сигнал 4 про завершення обчислення 7)
        monitor.signal_finish();

        System.out.println("Thread 1 has completed.");
    }
}