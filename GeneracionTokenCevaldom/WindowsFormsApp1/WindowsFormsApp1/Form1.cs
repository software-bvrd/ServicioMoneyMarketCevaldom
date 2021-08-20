using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Net;
using System.IO;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member 'Form1'
    public partial class Form1 : Form
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member 'Form1'
    {
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member 'Form1._strbody'
        public string _strbody = "";
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member 'Form1._strbody'
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member 'Form1._strfilename'
        public string _strfilename = "";
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member 'Form1._strfilename'
        ArrayList Lista = new ArrayList();
        int rownumber2 = 0;

        /// <summary>
        /// inicializacion de formulario
        /// </summary>
        public Form1()
        {
            InitializeComponent();
        }
        ///Conexion a la Base de datos 
        public static string ConectionString
        {
            get
            {
                return @"Data Source=ARP01\SQL_REPORT_01;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
            }

        } 
        /// <summary>
        /// Genera el COdigo desde la base de datos
        /// </summary>
        public DataSet DsObtieneCodigo()
        { 
            DataSet ds = new DataSet();
            try
            {
                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_GEN_CEVALDOM_OPER_CODIGO", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();

                        SqlDataAdapter adp = new SqlDataAdapter(cmd);
                        adp.Fill(ds);
                    }
                }
                return ds;
            }
            catch (Exception ex)
            {

                _strbody = "Webservice Money Market - Error: " + ex.Message.ToString() + " " + "; NOTA:  CONSULTANDO LA BASE DE DATOS ";
                _strfilename = "";
                //SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                return ds;
            }
        }

#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member 'Form1.RandomNumber()'
        public int RandomNumber()
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member 'Form1.RandomNumber()'
        {
            int rownumber = 0;
            // Random random = new Random(); //Guid.NewGuid().GetHashCode()
            //rownumber = random.Next(0, 9);
            DataSet ds = DsObtieneCodigo();
            rownumber = Int32.Parse(ds.Tables[0].Rows[0]["codigo"].ToString());
            //rownumber2 = rownumber;
            //Console.WriteLine("CODIGO2 RANDOM: " + rownumber2.ToString());
            /*
            if (rownumber2 == rownumber)
            { rownumber = RandomNumber(); }
            if ((rownumber2 - 1) == rownumber)
            { rownumber = RandomNumber(); }*/
            if (Lista.Contains(rownumber))
            {
                ds = DsObtieneCodigo();
                rownumber = Int32.Parse(ds.Tables[0].Rows[0]["codigo"].ToString());
                //Console.WriteLine("CODIGO RANDOM: " + rownumber.ToString());
                if (rownumber2 == rownumber)
                {
                    ds = DsObtieneCodigo();
                    rownumber = Int32.Parse(ds.Tables[0].Rows[0]["codigo"].ToString());
                }


            };
            Lista.Add(rownumber);
            if (Lista.Count == 10)
            {
                Lista.Clear();
                rownumber2 = 0;
                ds = DsObtieneCodigo();
                rownumber = Int32.Parse(ds.Tables[0].Rows[0]["codigo"].ToString());
            };
            rownumber2 = rownumber;
            if ((rownumber2 - 1) == rownumber)
            {
                //ds = DsObtieneCodigo();
                rownumber = rownumber + 1;
                if (rownumber > 9)
                {
                    ds = DsObtieneCodigo();
                    rownumber = Int32.Parse(ds.Tables[0].Rows[0]["codigo"].ToString());
                }
                Lista.Add(rownumber);
            }
            Console.WriteLine("CODIGO RANDOM: " + rownumber.ToString());
            return rownumber;
        }
        ///Al hacer click en este boton generar el codigo, la fecha y el token solicitado por cevaldom
        private void button1_Click(object sender, EventArgs e)
        {
            
#pragma warning disable CS0219 // The variable 'i' is assigned but its value is never used
            int i = 0;
#pragma warning restore CS0219 // The variable 'i' is assigned but its value is never used
            //Create a DataTable dt.   
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[3] { new DataColumn("CODIGO", typeof(string)),
                                                    new DataColumn("NUMERO", typeof(string)),
                                                    new DataColumn("GUID", typeof(Int64))});
            //DataTable dt1 = new DataTable();
            /* BUSCO EL CODIGO SELECCIONANDO UN RANDOM*/
            #region 
            dt.Rows.Add();
            dt.Rows[0]["CODIGO"] = "0";
            dt.Rows[0]["NUMERO"] = "9936";
            dt.Rows[0]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[0]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[1]["CODIGO"] = "1";
            dt.Rows[1]["NUMERO"] = "8576";
            dt.Rows[1]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[1]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[2]["CODIGO"] = "2";
            dt.Rows[2]["NUMERO"] = "9350";
            dt.Rows[2]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[2]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[3]["CODIGO"] = "3";
            dt.Rows[3]["NUMERO"] = "8116";
            dt.Rows[3]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[3]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[4]["CODIGO"] = "4";
            dt.Rows[4]["NUMERO"] = "9825";
            dt.Rows[4]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[4]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[5]["CODIGO"] = "5";
            dt.Rows[5]["NUMERO"] = "2819";
            dt.Rows[5]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[5]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[6]["CODIGO"] = "6";
            dt.Rows[6]["NUMERO"] = "7789";
            dt.Rows[6]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[6]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[7]["CODIGO"] = "7";
            dt.Rows[7]["NUMERO"] = "9277";
            dt.Rows[7]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[7]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[8]["CODIGO"] = "8";
            dt.Rows[8]["NUMERO"] = "8652";
            dt.Rows[8]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[8]["GUID"] = Guid.NewGuid().ToString();

            dt.Rows.Add();
            dt.Rows[9]["CODIGO"] = "9";
            dt.Rows[9]["NUMERO"] = "2391";
            dt.Rows[9]["GUID"] = System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
            //dt.Rows[9]["GUID"] = Guid.NewGuid().ToString();

            int rownumber = RandomNumber();

            // Console.WriteLine("CODIGO: " + dt.Rows[rownumber]["CODIGO"].ToString());
            // Console.WriteLine("NUMERO: " + dt.Rows[rownumber]["NUMERO"].ToString());
            // Console.WriteLine("Linea: " +  i.ToString() );
            //Console.WriteLine("Operacion: " + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString());

            txtdate.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss"); //"04/09/2020 10:15:00"; // 
            txtcode.Text =dt.Rows[rownumber]["CODIGO"].ToString(); // "8"; //
            //Console.Write(strcode);
            txtnumero.Text = dt.Rows[rownumber]["NUMERO"].ToString(); //"8652";  //
            txtguid.Text = dt.Rows[rownumber]["GUID"].ToString(); //"13750807"; //
            //dt1.Clear();
            txtuser.Text = "BVRDADM";
            txtmensaje.Text = txtuser.Text.Trim() + txtdate.Text.Trim();

            /* GENERO EL TOKEN*/
            // change according to your needs, an UTF8Encoding
            // could be more suitable in certain situations
            //ASCIIEncoding encoding = new System.Text.ASCIIEncoding();
            ////UTF8Encoding encoding = new UTF8Encoding(true);
            //Byte[] textBytes = encoding.GetBytes(txtmensaje.Text.Trim());
            //string strnumero = "";
            //strnumero = txtnumero.ToString().Trim();
            //Byte[] keyBytes = encoding.GetBytes(strnumero.ToString().Trim()); 
            //encoding.GetBytes(strnumero.ToString().Trim()); 
            //Byte[] hashBytes;
            //using (HMACSHA256 hash = new HMACSHA256(keyBytes))
            //    hashBytes = hash.ComputeHash(textBytes);
            //txttoken.Text = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            /* GENERO EL TOKEN*/
            Encoding iso8859 = Encoding.GetEncoding("iso-8859-1");
            Encoding unicode = Encoding.ASCII;
            byte[] srcTextBytesnumero = iso8859.GetBytes(txtnumero.Text.ToString().Trim());
            byte[] srcTextBytesmensaje = iso8859.GetBytes(txtmensaje.Text.ToString().Trim());
            byte[] destTextBytes = Encoding.Convert(iso8859, unicode, srcTextBytesnumero);
            char[] destChars = new char[unicode.GetCharCount(destTextBytes, 0, destTextBytes.Length)];
            unicode.GetChars(destTextBytes, 0, destTextBytes.Length, destChars, 0);
            System.String szchar = new System.String(destChars);
            Byte[] hashBytes;

            using (HMACSHA256 hash = new HMACSHA256(srcTextBytesnumero))
                hashBytes = hash.ComputeHash(srcTextBytesmensaje);
            txttoken.Text = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();


        }


    }
}
#endregion