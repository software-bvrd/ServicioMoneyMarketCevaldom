using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member 'Form2'
    public partial class Form2 : Form
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member 'Form2'
    {
        /// <summary>
        /// Inicializacion del formulario
        /// </summary>
        public Form2()
        {
            InitializeComponent();
        }
        /// <summary>
        /// solo para probar documentaciond de boton en form2
        /// </summary>
        ///solo para probar documentaciond de boton en form2
        private void button1_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Prueba hola");

        }
    }
}
