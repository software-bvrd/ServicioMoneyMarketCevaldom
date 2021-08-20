using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;

namespace WindowsFormsApp8
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        { 

            // Create new stopwatch.
            Stopwatch stopwatch = new Stopwatch();

            // Begin timing.
            stopwatch.Start();

            // Do something.
            for (int i = 0; i < 1000; i++)
            {
                Thread.Sleep(1000 * 30 * 1);
                //Console.WriteLine("duracion " + stopwatch.Elapsed);
                textBox1.Text = textBox1.Text + "\r\n" + i.ToString() + " HORA:"+ DateTime.Now.ToString("dddd, dd MMMM yyyy HH:mm:ss")+ ", DURACION : " + stopwatch.Elapsed;
                Application.DoEvents();
                //extBox1.Text += sent + "\r\n";
            }


            // Stop timing.
            //stopwatch.Stop();

            // Write result.
            //Console.WriteLine("Time elapsed: {0}", stopwatch.Elapsed);


        }
        private async  void ejecutar()
        {

            // Create new stopwatch.
            Stopwatch stopwatch = new Stopwatch();

            // Begin timing.
            stopwatch.Start();

            // Do something.
            for (int i = 0; i < 1000; i++)
            {
                Thread.Sleep(1000 * 30 * 1);
                //Console.WriteLine("duracion " + stopwatch.Elapsed);
                textBox1.Text = textBox1.Text + "\r\n" + i.ToString() + " HORA:" + DateTime.Now.ToString("dddd, dd MMMM yyyy HH:mm:ss") + ", DURACION : " + stopwatch.Elapsed;
                Application.DoEvents();
                //extBox1.Text += sent + "\r\n";
            } 
        }

        private void button2_Click(object sender, EventArgs e)
        {
             ejecutar();
        }
    }
}
