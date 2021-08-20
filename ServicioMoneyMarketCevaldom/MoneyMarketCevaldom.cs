using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Runtime.InteropServices;

using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Net.Http;
using System.Net;
using System.IO;
using System.Net;
using System.Reflection;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Collections;
using System.Xml;

namespace WindowsService1
{
    public partial class MoneyMarketCevaldom : ServiceBase
    {
        public string strtoken = "";
        public string _strbody = "";
        public string _strfilename = "";
        [DllImport("advapi32.dll", SetLastError = true)]
        private static extern bool SetServiceStatus(System.IntPtr handle, ref ServiceStatus serviceStatus);
        private int eventId = 1;
        public string strruta = @"\\ARP12b\xml\";
        ArrayList Lista = new ArrayList();
        //ArrayList Dias = new ArrayList();
        //Dias. = ["SATURDAY","SUNDAY"];
        string[] Dias = new string[2] { "SÁBADO", "DOMINGO" };
        string[] HorarioEstadoLiquidacion = new string[9] { "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00" };
        int rownumber2 = 0;
        string strdate = "";
        string struser = "BVRDADM";
        string strcode = "";
        string strnumero = "";
        string strmensaje = "";
        string strguid = "";
        HttpWebResponse webResponse1 = null;
        int errorCode = 0;
        string errorCodeDescription = "";
        private string txtUserName = @"bvrd\soportetecnico3";
        private string txtPassword = "Sop##bv6697";
        private string ESTATUS;
        private string VENDEDOR;
        private string COMPRADOR;
        private string MECANISMO;
        private Int64 MODALIDAD;
        private string REFERENCIA;
        private string PACTADA;
        private Int64 PROCESO;
        private Int64 SOLICITUD;
        private string OPERACION;
        private string TRN;
        private string ESTADO;
        ArrayList Cadena = new ArrayList();
        private string RESPUESTA;
        private string CONTADO;
        private string PLAZO;
        string strCadena;
        int HoraMercadoInicial = 7;
        int HoraMercadoFinal = 14;// 14;
        

        //public string strruta = @"\\BV004\temp\";

        public static string ConectionString
        {
            get
            { 
                //return ConfigurationManager.AppSettings["INTERFACE_ConectionString"].ToString();
                //return @"Data Source=ARP01\SQL_REPORT_01;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
                return "Data Source=ADB03;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
            }

        }


        //public static string AppName
        //{
        //    get
        //    {

        //        return ConfigurationManager.AppSettings["AppName"].ToString();
        //        //@"Data Source=ARP01\SQL_REPORT_01;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
        //        //@"Data Source=ARP01\SQL_REPORT_01;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
        //        //return @"Data Source=ADB03;Initial Catalog=SIOPEL_INTERFACE_DB;User ID=developer;Password=admin@123";
        //    }

        //}

        protected override void OnStart(string[] args)
        {
            GenerarToken();
            //EstadosOperacionesWS();
            //string archivo = @"\\ARP01\xml\file.xml";
            //DesBloqueoArchivo(archivo);

            /*
            System.IO.File.Create(AppDomain.CurrentDomain.BaseDirectory + "OnStart.txt");
            eventLog1.WriteEntry("In OnStart."); 
            // Update the service state to Start Pending
            ServiceStatus serviceStatus = new ServiceStatus();
            serviceStatus.dwCurrentState = ServiceState.SERVICE_START_PENDING;
            serviceStatus.dwWaitHint = 100000;
            SetServiceStatus(this.ServiceHandle, ref serviceStatus);
            // Set up a timer that triggers every minute.
            Timer timer = new Timer();
            timer.Interval = 60000; // 60 seconds
            timer.Elapsed += new ElapsedEventHandler(this.OnTimer);
            timer.Start();

            // Update the service state to Running.
            serviceStatus.dwCurrentState = ServiceState.SERVICE_RUNNING;
            SetServiceStatus(this.ServiceHandle, ref serviceStatus);
            */

        }
        public void OnDebug()
        {
            OnStart(null);
            /*_strbody = "pROBANDO ";
            _strfilename = "";
            SendMail("Error ENVIO WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());*/

        }
        public void OnTimer(object sender, ElapsedEventArgs args)
        {
            // TODO: Insert monitoring activities here. 
            eventLog1.WriteEntry("Monitoring the System", EventLogEntryType.Information, eventId++);
        }
        protected override void OnStop()
        {

            System.IO.File.Create(AppDomain.CurrentDomain.BaseDirectory + "OnStop.txt");
            eventLog1.WriteEntry("In OnStop.", EventLogEntryType.Error, eventId++);
            // Update the service state to Stop Pending.

            ServiceStatus serviceStatus = new ServiceStatus();
            serviceStatus.dwCurrentState = ServiceState.SERVICE_STOP_PENDING;
            serviceStatus.dwWaitHint = 100000;
            SetServiceStatus(this.ServiceHandle, ref serviceStatus);

            // Update the service state to Stopped.
            serviceStatus.dwCurrentState = ServiceState.SERVICE_STOPPED;
            SetServiceStatus(this.ServiceHandle, ref serviceStatus);

        }
        protected override void OnContinue()
        {
            eventLog1.WriteEntry("In OnContinue.");
        }

        public void GenerarToken()
        {
            int horaMercado = -1;
            DateTime Hoy = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            string NombredelDia = Hoy.ToString("dddd", new CultureInfo("es-ES")).ToUpper();
            //if (Dias.)
            bool ValidaFindeSemana = Dias.Contains(NombredelDia);
            horaMercado = Convert.ToInt16(DateTime.Now.ToString("HH"));
            if (ValidaFindeSemana == false)
            {
                if (horaMercado > HoraMercadoInicial && horaMercado < HoraMercadoFinal)
                {
                    DataSet dsoperaciones = DsCuentaOperaciones();
                    int i = 0;
                    #region 
                    if (dsoperaciones.Tables[0].Rows.Count > 0)
                    {
                        //Create a DataTable dt.   
                        DataTable dt = new DataTable();
                    dt.Columns.AddRange(new DataColumn[3] { new DataColumn("CODIGO", typeof(string)),
                                                    new DataColumn("NUMERO", typeof(string)),
                                                    new DataColumn("GUID", typeof(Int64))});
                    //DataTable dt1 = new DataTable();
                    /* BUSCO EL CODIGO SELECCIONANDO UN RANDOM*/
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
                    #endregion
                        try
                        {
                            while (i <= dsoperaciones.Tables[0].Rows.Count - 1)
                            {
                                //var result = dt.AsEnumerable().OrderByDescending(r => r.Field<Int64>("GUID"));
                                //dt.Clear();
                                //var result = dt.AsEnumerable().OrderByDescending(r => r.Field<string>("GUID").FirstOrDefault());
                                //var newList = dt.AsEnumerable().OrderByDescending(x => x.GUID).Reverse();
                                //var result = dt.Rows.Cast<DataRow>().OrderBy(rand => r.Next()).Take(3);

                                // dt1 = dt; // result.CopyToDataTable();

                                int rownumber = RandomNumber();

                                // Console.WriteLine("CODIGO: " + dt.Rows[rownumber]["CODIGO"].ToString());
                                // Console.WriteLine("NUMERO: " + dt.Rows[rownumber]["NUMERO"].ToString());
                                // Console.WriteLine("Linea: " +  i.ToString() );
                                Console.WriteLine("Operacion: " + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString());

                                strdate = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                                strcode = dt.Rows[rownumber]["CODIGO"].ToString();
                                //Console.Write(strcode);
                                strnumero = dt.Rows[rownumber]["NUMERO"].ToString();
                                strguid = dt.Rows[rownumber]["GUID"].ToString();
                                //dt1.Clear();
                                strmensaje = struser.ToString().Trim() + strdate.ToString().Trim();

                                /* GENERO EL TOKEN*/
                                // change according to your needs, an UTF8Encoding
                                // could be more suitable in certain situations
                                ASCIIEncoding encoding = new ASCIIEncoding();
                                Byte[] textBytes = encoding.GetBytes(strmensaje);
                                int len = ASCIIEncoding.Default.GetByteCount(strnumero.ToString().Trim());
                                Byte[] keyBytes = encoding.GetBytes(strnumero.ToString().Trim());
                                Byte[] hashBytes;

                                using (HMACSHA256 hash = new HMACSHA256(keyBytes))
                                    hashBytes = hash.ComputeHash(textBytes);
                                strtoken = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                                /* ENVIO LA INFORMACION A CEVALDOM*/
                                string dataoperacionmoneymarket = dsoperaciones.Tables[0].Rows[i]["CADENA"].ToString();
                                if (dataoperacionmoneymarket != "")
                                {
                                    //** Ambiente de Pruebas ***//
                                    //string url = "http://prejbosrv02.cevaldom.local:8080/cevaldom-webservices/negotiation/v1/operationRequest";
                                    //**Ambiente de Producción
                                    string url = "https://cvdpserver.local/cevaldom-webservices/negotiation/v1/operationRequest";


                                    //HttpWebRequest request = WebRequest.Create(url + dataoperacionmoneymarket) as HttpWebRequest;
                                    HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                                    request.Credentials = CredentialCache.DefaultCredentials;

                                    //byte[] bytes;
                                    //bytes = System.Text.Encoding.ASCII.GetBytes(dataoperacionmoneymarket);
                                    //request.ContentType = "application/xml; encoding='utf-8'";
                                    //request.ContentLength = bytes.Length;
                                    request.Method = "POST";
                                    MethodInfo priMethod = request.Headers.GetType().GetMethod("AddWithoutValidate", BindingFlags.Instance | BindingFlags.NonPublic);
                                    priMethod.Invoke(request.Headers, new[] { "user", struser.ToString() });
                                    priMethod.Invoke(request.Headers, new[] { "code", strcode.ToString() });

                                    object[] mydate = new object[2];
                                    mydate[0] = "date";
                                    mydate[1] = strdate;
                                    priMethod.Invoke(request.Headers, mydate);
                                    priMethod.Invoke(request.Headers, new[] { "token", strtoken.ToString() });
                                    priMethod.Invoke(request.Headers, new[] { "Accept", "application/xml" });
                                    priMethod.Invoke(request.Headers, new[] { "Content-Type", "application/xml" });
                                    byte[] dataStream = Encoding.UTF8.GetBytes(dataoperacionmoneymarket.ToString());
                                    Stream newStream = request.GetRequestStream();
                                    newStream.Write(dataStream, 0, dataStream.Length);
                                    newStream.Close();
                                    /*if (dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString() == "20022415593")
                                    {
                                        int aa = 0;
                                    }*/

                                    WebResponse webResponse = null;
                                    try
                                    {
                                        webResponse = request.GetResponse();
                                        errorCodeDescription = ((HttpWebResponse)webResponse).StatusDescription.ToString();
                                        MarcaOperacionEnviada(Convert.ToInt64(dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString()));
                                        errorCode = 1;
                                    }
                                    catch (WebException e)
                                    {
                                        webResponse1 = (HttpWebResponse)e.Response;
                                        if (e.Status == WebExceptionStatus.ProtocolError)
                                        { 
                                            MarcaOperacionEnviada(Convert.ToInt64(dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString()));
                                            //Console.Write("Errorcode: {0}", (int)webResponse1.StatusCode);

                                        }
                                        else
                                        {
                                            Console.Write("Error: {0}", e.Status);
                                        }
                                        errorCode = (int)webResponse1.StatusCode;
                                        errorCodeDescription = webResponse1.StatusCode.ToString();
                                        webResponse = webResponse1;
                                    }
                                    string strdatefile = String.Format("{0:MMddyyyyHHmmss}", strdate);
                                    strdatefile = strdate.Replace("/", "");
                                    strdatefile = strdatefile.Replace(":", "");
                                    strdatefile = strdatefile.Replace(" ", "");
                                    //if (errorCode != 400)
                                    //{
                                    try
                                    {
                                        // string strdatefile = String.Format("{0:MMddyyyyHHmmss}", strdate);  
                                        // string responseFile = strruta + "NotificacionCevaldom_" + strdatefile.ToString() + ".xml";
                                        string newguid = "_" + System.Math.Abs(Guid.NewGuid().GetHashCode()).ToString();
                                        string responseFile = strruta + "NotifiCVD_" + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString() + newguid.ToString();
                                        DesBloqueoArchivo(responseFile);
                                        using (Stream responseStream = webResponse.GetResponseStream())
                                        {
                                            if (responseStream != null && responseStream != Stream.Null)
                                            {
                                                using (StreamReader streamReader = new StreamReader(responseStream))
                                                {
                                                    string responseText = streamReader.ReadToEnd();
                                                    byte[] responseBytes = Encoding.UTF8.GetBytes(responseText);
                                                    // FileStream fs = new FileStream(responseFile, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                                                    //fs.Write(responseBytes,0,0);
                                                    //fs.Close(); 
                                                    File.WriteAllBytes(responseFile, responseBytes);

                                                }

                                                try
                                                {
                                                    if (File.Exists(responseFile))
                                                    {
                                                        NotificacionCevaldom(responseFile, dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString(), errorCodeDescription.ToString());
                                                    }
                                                }
                                                catch (Exception ex)
                                                {
                                                    _strbody = "Webservice Money Market - Error:  " + ex.Message.ToString() + " " + "; creando arhivo respuesta cevaldom de la OPERACION #: " + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString();
                                                    _strfilename = "";
                                                    SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                                                }
                                            }
                                        }
                                        Deletefile(responseFile);
                                    }
                                    catch (WebException ex)
                                    {
                                        /*   using (WebResponse response = e.Response)
                                           {
                                               HttpWebResponse httpResponse = (HttpWebResponse)response;
                                               Console.WriteLine("Error code: ", httpResponse.StatusCode);
                                               using (Stream data = response.GetResponseStream())
                                               using (var reader = new StreamReader(data))
                                               {
                                                   string text = reader.ReadToEnd();
                                                   Console.WriteLine(text);
                                               }
                                           }*/
                                        string responseFile = strruta + "ErrorEnvioOperacionesCevaldom_" + strdatefile.ToString() + ".xml";
                                        string responseText = dsoperaciones.Tables[0].Rows[i]["cadena"].ToString();
                                        byte[] responseBytes = Encoding.UTF8.GetBytes(responseText);
                                        File.WriteAllBytes(responseFile, responseBytes);
                                        _strbody = "Ha ocurrido un error en el envio de la operación adjunto, <br> <strong> DESCRIPCION ERROR #: " + ex.Message.ToString() + "</strong> <br> NUMERO #:" + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString() + "; NOTA: ESCRIBIENDO EL ARCHIVO DE NotificacionCevaldom.XML" + "; DESCRIPCION ERROR: " + errorCodeDescription;
                                        _strfilename = responseFile;
                                        SendMail("Error ENVIO WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                                    }

                                    /* MARCO LA OPERACION COMO ENVIADA PARA NO ENVIARLA OTRA VEZ*/
                                    if (errorCode == 201)
                                        MarcaOperacionEnviada(Convert.ToInt64(dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString()));
                                    //} //if (errorCode != 400)
                                }
                                i = i + 1;
                            }

                        }// while
                        catch (Exception ex)
                        {

                            _strbody = "Webservice Money Market - Error:  " + ex.Message.ToString() + " " + "; NOTA: ENVIANDO LA OPERACION #: " + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString() +
                                "; PARAMETRO : " + dsoperaciones.Tables[0].Rows[i]["CADENA"].ToString() + "; CODIGO: " + strcode + "; FECHA: " + strdate + "; TOKEN #: " + strtoken + "; DESCRIPCION ERROR: " + errorCodeDescription;
                            _strfilename = "";
                            SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                            //throw new Exception(string.Format("Webservice Money Market - Error: ", ex.Message));
                        }//try 
                    }//if (ds.Tables[0].Rows.Count > 0)

                    //Consulto el estado de las liquidaciones de las operaciones
                    EstadosOperacionesWS();
                } // if (moment > 7 && moment < 14)
            } //if (ValidaFindeSemana == false)
        }

        public void EstadosOperacionesWS()
        {
            int horaMercado = -1;
            DateTime Hoy = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            string NombredelDia = Hoy.ToString("dddd", new CultureInfo("es-ES")).ToUpper();
            //if (Dias.)
            bool ValidaFindeSemana = Dias.Contains(NombredelDia);
            string horaEstado = Convert.ToString(DateTime.Now.ToString("HH:mm"));
            bool ValidaHorarioEstadoLiq = HorarioEstadoLiquidacion.Contains(horaEstado.ToString());
            horaMercado = Convert.ToInt16(DateTime.Now.ToString("HH"));
            Console.Write(ValidaHorarioEstadoLiq.ToString());
            if (ValidaFindeSemana == false)
            {
                if (horaMercado > HoraMercadoInicial  && horaMercado < HoraMercadoFinal)
               // if (ValidaHorarioEstadoLiq == true) 
                { 
                    //DataSet dsoperaciones = DsCuentaOperaciones();
                    int i = 0;
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

                    //if (dsoperaciones.Tables[0].Rows.Count > 0)
                    // {
                    try
                    {
                        // while (i <= dsoperaciones.Tables[0].Rows.Count - 1)
                        // {
                        int rownumber = RandomNumber();
                        //Console.WriteLine("Operacion: " + dsoperaciones.Tables[0].Rows[i]["NUMERO_OPERACION"].ToString());

                        strdate = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                        strcode = dt.Rows[rownumber]["CODIGO"].ToString();
                        //Console.Write(strcode);
                        strnumero = dt.Rows[rownumber]["NUMERO"].ToString();
                        strguid = dt.Rows[rownumber]["GUID"].ToString();
                        //dt1.Clear();
                        strmensaje = struser.ToString().Trim() + strdate.ToString().Trim();

                        /* GENERO EL TOKEN*/
                        // change according to your needs, an UTF8Encoding
                        // could be more suitable in certain situations
                        ASCIIEncoding encoding = new ASCIIEncoding();
                        Byte[] textBytes = encoding.GetBytes(strmensaje);
                        int len = ASCIIEncoding.Default.GetByteCount(strnumero.ToString().Trim());
                        Byte[] keyBytes = encoding.GetBytes(strnumero.ToString().Trim());
                        Byte[] hashBytes;

                        using (HMACSHA256 hash = new HMACSHA256(keyBytes))
                            hashBytes = hash.ComputeHash(textBytes);
                        strtoken = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
                        #endregion
                        /* ENVIO LA INFORMACION A CEVALDOM*/
                        // string dataoperacionmoneymarket = dsoperaciones.Tables[0].Rows[i]["CADENA"].ToString();
                        //if (dataoperacionmoneymarket != "")
                        // {
                        DateTime Hoy1 = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);

                        string FechaInicial = Hoy1.ToString("dd/MM/yyyy", new CultureInfo("es-ES")).ToUpper(); //"01/01/2020"; 
                        string FechaFinal = Hoy1.ToString("dd/MM/yyyy", new CultureInfo("es-ES")).ToUpper();
                        //endpoint ambiente de desarrollo
                        //string url = "http://prejbosrv02.cevaldom.local:8080/cevaldom-webservices/negotiation/v1/getOperationRequest?FechaInicial=" + FechaInicial.ToString() + "&FechaFinal=" + FechaFinal.ToString();
                        //endpoint ambiente de produccion
                        string url = "https://cvdpserver.local/cevaldom-webservices/negotiation/v1/getOperationRequest?FechaInicial=" + FechaInicial.ToString() + "&FechaFinal=" + FechaFinal.ToString();
                        HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                        request.Credentials = CredentialCache.DefaultCredentials;
                        request.Method = "GET";
                        MethodInfo priMethod = request.Headers.GetType().GetMethod("AddWithoutValidate", BindingFlags.Instance | BindingFlags.NonPublic);
                        priMethod.Invoke(request.Headers, new[] { "user", struser.ToString() });
                        priMethod.Invoke(request.Headers, new[] { "code", strcode.ToString() });

                        object[] mydate = new object[2];
                        mydate[0] = "date";
                        mydate[1] = strdate;
                        priMethod.Invoke(request.Headers, mydate);
                        priMethod.Invoke(request.Headers, new[] { "token", strtoken.ToString() });
                        priMethod.Invoke(request.Headers, new[] { "Accept", "application/xml" });
                        priMethod.Invoke(request.Headers, new[] { "Content-Type", "application/xml" });
                        using (WebResponse response = request.GetResponse())
                        {

                            using (Stream stream = response.GetResponseStream())
                            {

                                XmlTextReader reader = new XmlTextReader(stream);
                                //reader.Read();
                                while (reader.Read())
                                {
                                    strCadena = "";
                                    if (reader.Name != "")
                                    {
                                        if (reader.Name == "Estatus")
                                        {
                                            ESTATUS = reader.ReadString();
                                            strCadena = ESTATUS;
                                        }
                                        if (reader.Name == "VENDEDOR")
                                        {
                                            VENDEDOR = reader.ReadString();
                                            strCadena = VENDEDOR;
                                        }
                                        if (reader.Name == "COMPRADOR")
                                        {
                                            COMPRADOR = reader.ReadString();
                                            strCadena = COMPRADOR;
                                        }
                                        if (reader.Name == "MECANISMO")
                                        {
                                            MECANISMO = reader.ReadString();
                                            strCadena = MECANISMO;
                                        }
                                        if (reader.Name == "MODALIDAD")
                                        {
                                            try
                                            {
                                                strCadena = reader.ReadString();
                                                if (!String.IsNullOrEmpty(strCadena))
                                                    MODALIDAD = Convert.ToInt64(strCadena);
                                                else
                                                    MODALIDAD = 0;
                                            }
                                            finally { }

                                        }
                                        if (reader.Name == "REFERENCIA")
                                        {
                                            REFERENCIA = reader.ReadString();
                                            strCadena = REFERENCIA;
                                        }
                                        if (reader.Name == "PACTADA")
                                        {
                                            PACTADA = reader.ReadString();
                                            strCadena = PACTADA;
                                        }
                                        if (reader.Name == "PROCESO")
                                        {
                                            try
                                            {
                                                strCadena = reader.ReadString();
                                                if (!String.IsNullOrEmpty(strCadena))
                                                    PROCESO = Convert.ToInt64(strCadena);
                                                else
                                                    PROCESO = 0;

                                            }
                                            finally { }
                                        }
                                        if (reader.Name == "SOLICITUD")
                                        {
                                            try
                                            {
                                                strCadena = reader.ReadString();
                                                if (!String.IsNullOrEmpty(strCadena))
                                                    SOLICITUD = Convert.ToInt64(strCadena);
                                                else
                                                    SOLICITUD = 0;

                                            }
                                            finally { }
                                        }
                                        if (reader.Name == "OPERACION")
                                        {
                                            OPERACION = reader.ReadString();
                                            strCadena = OPERACION;
                                        }
                                        if (reader.Name == "TRN")
                                        {
                                            TRN = reader.ReadString();
                                            strCadena = TRN;
                                        }
                                        if (reader.Name == "CONTADO")
                                        {
                                            CONTADO = reader.ReadString();
                                            strCadena = CONTADO;
                                        }
                                        if (reader.Name == "PLAZO")
                                        {
                                            PLAZO = reader.ReadString();
                                            strCadena = PLAZO;
                                        }
                                        //if (reader.Name == "Respuesta")
                                        //{
                                        //    RESPUESTA = reader.ReadString();
                                        //    strCadena = RESPUESTA;
                                        //}
                                        if (reader.Name == "ESTADO")
                                        {
                                            ESTADO = reader.ReadString();
                                            strCadena = ESTADO;
                                            EstadoOperacionLiquidacionCevaldom(ESTATUS, VENDEDOR, COMPRADOR, MECANISMO, MODALIDAD, REFERENCIA, PACTADA, PROCESO, SOLICITUD, OPERACION, TRN, CONTADO, PLAZO, ESTADO);
                                        }
                                        //if (strCadena != "") Cadena.Add(reader.Name.ToString() + " = " + strCadena);
                                    }
                                }
                            }
                        }
                    }// try
                    catch (WebException ex)
                    {
                        webResponse1 = (HttpWebResponse)ex.Response;
                        errorCode = (int)webResponse1.StatusCode;
                        if (errorCode != 401 && errorCode != 404)
                        {
                            _strbody = "Webservice Money Market - Error:  " + ex.Message.ToString() + " " + "; Consultando el estado de liquidacion de las operaciones ";
                            _strfilename = "";
                            SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                        }
                    }//try 
                    //}//if (ds.Tables[0].Rows.Count > 0)
                } // if (moment > 7 && moment < 14)
            } //if (ValidaFindeSemana == false)
        }

        public MoneyMarketCevaldom()
        {
            InitializeComponent();
            string Mysource = "MoneyMarketCevaldom";

            eventLog1 = new System.Diagnostics.EventLog();
            if (!System.Diagnostics.EventLog.SourceExists(Mysource))
            {
                System.Diagnostics.EventLog.CreateEventSource(Mysource, "");
            }
            eventLog1.Source = Mysource;
            eventLog1.Log = "";


        }

        public DataSet DSenvioOperacionCevaldom(int numoperacion)
        {
            DataSet ds = new DataSet();
            try
            {
                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_GEN_CEVALDOM_OPER_WS_MONEYMARKET", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();

                        SqlDataAdapter adp = new SqlDataAdapter(cmd);
                        adp.Fill(ds);
                    }
                }
                return ds;
            }
            catch
            { return ds; }
        }

        public void MarcaOperacionEnviada(Int64 numoperacion)
        {
            DataSet ds = new DataSet();
            try
            {

                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_GEN_CEVALDOM_OPER_WS_MM_MARCAENVIADA", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        cmd.Parameters.Add("@NUMERO_OPERACION", SqlDbType.Decimal).Value = numoperacion;
                        int result = cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                _strbody = "Webservice Money Market - Error:  " + ex.Message.ToString() + " " + "; MARCANDO LA OPERACION #: " + numoperacion.ToString();
                _strfilename = "";
                SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
            }
        }

        public DataSet DsCuentaOperaciones()
        {
            DataSet ds = new DataSet();
            try
            {
                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_GEN_CEVALDOM_OPER_CUENTA_MM", con))
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
                SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                return ds;
            }
        }

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
                SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                return ds;
            }
        }

        public enum ServiceState
        {
            
            SERVICE_STOPPED = 0x00000001,
            //SERVICE_START_PENDING = 0x00000002,
            SERVICE_STOP_PENDING = 0x00000003,
            /*SERVICE_RUNNING = 0x00000004,
            SERVICE_CONTINUE_PENDING = 0x00000005,
            SERVICE_PAUSE_PENDING = 0x00000006,
            SERVICE_PAUSED = 0x00000007,
            */
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct ServiceStatus
        {
            public int dwServiceType;
            public ServiceState dwCurrentState;
            public int dwControlsAccepted;
            public int dwWin32ExitCode;
            public int dwServiceSpecificExitCode;
            public int dwCheckPoint;
            public int dwWaitHint;
        }

        public void SendMail(string Subject, string Body, string Attachments/*, string AuthUsername = null, string AuthPassword = null*/)
        {
            string server = Environment.MachineName.ToString();
            Subject = server + " : " + Subject;
            SmtpClient MailClient = new SmtpClient("bvrd-com-do.mail.protection.outlook.com", 25);
            //SmtpClient MailClient = new SmtpClient("smtp.office365.com", 25);
            string From = "notificaciones@bvrd.com.do";
            string To = "mcastillo@bvrd.com.do"; //tecnologia
            string AuthUsername = "notificaciones@bvrd.com.do";
            string AuthPassword = "Juko6315*f2";
            //Subject = AppName.ToString() + " - " + Subject;
            MailClient.Credentials = new System.Net.NetworkCredential(From, "");

            //MailClient.Credentials = new System.Net.NetworkCredential(AuthUsername, AuthPassword);
            var MailMessage = new MailMessage(From, To, Subject, Body);
            MailMessage.IsBodyHtml = true;

            /*if ((AuthUsername != null) && (AuthPassword != null))
            {
                {
                    //var withBlock = MailClient;
                    MailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    MailClient.UseDefaultCredentials = true;
                    MailClient.EnableSsl = true;
                    MailClient.Credentials = new System.Net.NetworkCredential(AuthUsername, AuthPassword);
                }
            }*/

            //Attachments = @"\\ARP01\xml\RECHAZADOS.xml";
            // MailMessage.Attachments.Add(new Attachment(Attachments));
            if ((Attachments.ToString() != ""))
            {
                //foreach (var FileName in Attachments)
                MailMessage.Attachments.Add(new Attachment(Attachments));
            }
            MailClient.Send(MailMessage);
            MailClient.Dispose();
            MailMessage.Dispose();
        }

        public void Deletefile(string filename)
        {
            if (filename.ToString() != "")
            {
                //debo cerrar el archivo antes de borrarlo.
                File.Delete(filename);
            }
        }
        public void DesBloqueoArchivo(string filename)
        {

            /*
            if (File.Exists(filename))
            {
                //public static SendEmail()
                {
                    MailMessage mMailMessage = new MailMessage();
                    //setup other email stuff

                    if (File.Exists(filename))
                    {
                        Attachment attachment = new Attachment(filename);
                        mMailMessage.Attachments.Add(attachment);
                        //attachment.Dispose(); //disposing the Attachment object
                    }
                }
            }*/

            // Desbloqueo de proceso
            List<Process> lstProcs = new List<Process>();


            lstProcs = ProcessHandler.WhoIsLocking(filename);
            foreach (Process p in lstProcs)
            {
                if (p.MachineName.ToUpper() == "SEP12B" || p.MachineName.ToUpper() == "APL" || p.MachineName.ToUpper() == ".")
                    ProcessHandler.localProcessKill(p.ProcessName);
                else
                    ProcessHandler.remoteProcessKill(p.MachineName, txtUserName, txtPassword, p.ProcessName);
            }
        }

        public void NotificacionCevaldom(string filename, string numerooperacion, string estado)
        {
            DataSet ds = new DataSet();
            try
            {
                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_SUBE_XML_RESPUESTA_OPERACIONESMM_CEVALDOM", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        cmd.Parameters.Add("@archivo", SqlDbType.VarChar).Value = filename;
                        cmd.Parameters.Add("@ESTADO", SqlDbType.VarChar).Value = estado;
                        cmd.Parameters.Add("@numerooperacion", SqlDbType.VarChar).Value = numerooperacion;
                        int result = cmd.ExecuteNonQuery();
                        con.Dispose();
                        if (File.Exists(filename))
                        {
                            using (var file = System.IO.File.OpenText(filename))
                            {
                                file.Close();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _strbody = "Webservice Money Market - Error: " + ex.Message.ToString() + " " + "; NOTA: SUBIENDO LA RESPUESTA DE CEVALDOM a la operacion # " + numerooperacion;
                _strfilename = "";
                SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
            }


        }

        public void EstadoOperacionLiquidacionCevaldom(string ESTATUS, string VENDEDOR, string COMPRADOR, string MECANISMO, Int64 MODALIDAD, string REFERENCIA, string PACTADA, Int64 PROCESO, Int64 SOLICITUD, string OPERACION, string TRN, string CONTADO, string PLAZO, string ESTADO)
        {
            DataSet ds = new DataSet();
            try
            {
                string strString = ConectionString;
                using (SqlConnection con = new SqlConnection(strString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_SUBE_XML_EstadoOperacionLiquidacion_CEVALDOM", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        cmd.Parameters.Add("@ESTATUS", SqlDbType.VarChar).Value = ESTATUS;
                        cmd.Parameters.Add("@VENDEDOR", SqlDbType.VarChar).Value = VENDEDOR;
                        cmd.Parameters.Add("@COMPRADOR", SqlDbType.VarChar).Value = COMPRADOR;
                        cmd.Parameters.Add("@MECANISMO", SqlDbType.VarChar).Value = MECANISMO;
                        cmd.Parameters.Add("@MODALIDAD", SqlDbType.Int).Value = MODALIDAD;
                        cmd.Parameters.Add("@REFERENCIA", SqlDbType.VarChar).Value = REFERENCIA;
                        if (String.IsNullOrEmpty(PACTADA))
                            { PACTADA = ""; }
                        cmd.Parameters.Add("@PACTADA", SqlDbType.VarChar).Value = PACTADA;
                        cmd.Parameters.Add("@PROCESO", SqlDbType.Int).Value = PROCESO;
                        cmd.Parameters.Add("@SOLICITUD", SqlDbType.Int).Value = SOLICITUD;
                        cmd.Parameters.Add("@OPERACION", SqlDbType.VarChar).Value = OPERACION;
                        cmd.Parameters.Add("@TRN", SqlDbType.VarChar).Value = TRN;
                        cmd.Parameters.Add("@CONTADO", SqlDbType.VarChar).Value = CONTADO;
                        cmd.Parameters.Add("@PLAZO", SqlDbType.VarChar).Value = PLAZO;
                        cmd.Parameters.Add("@ESTADO", SqlDbType.VarChar).Value = ESTADO;
                        int result = cmd.ExecuteNonQuery();
                        con.Dispose();
                        LimpiarVariables();
                    }
                }
            }
            catch (Exception ex)
            {
                _strbody = "Webservice Money Market - Error: " + ex.Message.ToString() + " " + "; NOTA: SUBIENDO EL ESTADO DE LAS OPERACION DE CEVALDOM DE LA SOLICITUD # " + SOLICITUD.ToString();
                _strfilename = "";
                SendMail("Error EJECUCION WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
            }

        }

        public void LimpiarVariables()
        {
            ESTATUS = "";
            VENDEDOR = "";
            COMPRADOR = "";
            MECANISMO = "";
            MODALIDAD = 0;
            REFERENCIA = "";
            PACTADA = "";
            PROCESO = 0;
            SOLICITUD = 0;
            OPERACION = "";
            TRN = "";
            ESTADO = "";
        }
        public int RandomNumber()
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

        public void aleatorio()
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[3] { new DataColumn("CODIGO", typeof(string)),
                                                    new DataColumn("NUMERO", typeof(string)),
                                                    new DataColumn("GUID", typeof(Int64))});
            ArrayList Lista = new ArrayList();
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
             
            Random rnd = new Random();
            int i = 0;
            foreach (DataRow row in dt.Rows)
            {
                row["GUID"] = rnd.Next(1, 1000000);
                //Console.WriteLine("CODIGO: " + dt.Rows[i]["CODIGO"].ToString());
                //Console.WriteLine("NUMERO: " + dt.Rows[i]["NUMERO"].ToString());
                i = i + 1;
            }

            DataView dv = dt.DefaultView;
            dv.Sort = "GUID";
            DataTable sortedDT = dv.ToTable();
            Console.WriteLine(sortedDT.Rows[0]["CODIGO"].ToString());
            Console.WriteLine(sortedDT.Rows[0]["NUMERO"].ToString());
            if (Lista.Count == 9)
            {
                Lista.Clear();
            }
            Lista.Add(sortedDT.Rows[0]["CODIGO"].ToString());
            if (Lista.Contains(sortedDT.Rows[0]["CODIGO"]))
            {

            }

        }
    }
}



