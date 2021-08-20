using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Globalization;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)

            {
                txtfecha.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string mensaje = txtusuario.Text.ToString().Trim() +  txtfecha.Text.ToString().Trim(); 
            txttoken.Text = mensaje;
          
            // change according to your needs, an UTF8Encoding
            // could be more suitable in certain situations
            ASCIIEncoding encoding = new ASCIIEncoding();

            Byte[] textBytes = encoding.GetBytes(mensaje);
            Byte[] keyBytes = encoding.GetBytes(txtcodigo.Text);

            Byte[] hashBytes;

            using (HMACSHA256 hash = new HMACSHA256(keyBytes))
                hashBytes = hash.ComputeHash(textBytes);

            txttoken.Text = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            

           /*
              String secretAccessKey = txtcodigo.Text;
             String data = mensaje;
             byte[] secretKey = Encoding.UTF8.GetBytes(secretAccessKey);
             HMACSHA256 hmac = new HMACSHA256(secretKey);
             hmac.Initialize();
             byte[] bytes = Encoding.UTF8.GetBytes(data);
             byte[] rawHmac = hmac.ComputeHash(bytes); 
             txttoken.Text =  Convert.ToBase64String(rawHmac).ToString();
         
    */



        }
    }
}