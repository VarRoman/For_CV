public class Monitor {
    private int d = 0;
    private int a = 0;
    private int F_input = 0;
    private int L_sort1 = 0;
    private int L_sort2 = 0;
    private int L_sort3 = 0;
    private int L_sort4 = 0;
    private int F_min = 0;
    private int F_result = 0;
    public synchronized int get_a(){ return a; }
    public synchronized int get_d(){ return d; }
    public synchronized void set_d(int d){ this.d = d; }
    public synchronized void set_a(int ai){ this.a = Math.max(this.a, ai); }
    
    
    public synchronized void input_signal(){
        F_input += 1;
        if(F_input == 2){
            notifyAll();
        }
    }
    public synchronized void wait_input() {
        while(F_input != 2) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    public synchronized void signal_sort1(){
        L_sort1 += 1;
        notifyAll();

    }
    public synchronized void wait_sort1() {
        while(L_sort1 != 1) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    public synchronized void signal_sort2(){
        L_sort2 += 1;
        notifyAll();
    }
    public synchronized void wait_sort2() {
        while(L_sort2 != 1) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    public synchronized void signal_sort3(){
        L_sort3 += 1;
        notifyAll();
    }
    public synchronized void wait_sort3() {
        while(L_sort3 != 1) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    public synchronized void signal_sort4(){
        L_sort4 += 1;
        notifyAll();
    }
    public synchronized void wait_sort4() {
        while(L_sort4 != 1) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public synchronized void signal_calc(){
        F_min += 1;
        if(F_min == 4){ notifyAll();}
    }

    public synchronized void wait_calc() {
        while(F_min != 4) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    public synchronized void signal_finish(){
        F_result += 1;
        if(F_result == 3){
            notify();
        }
    }
    public synchronized void wait_finish() {
        while(F_result != 3) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}