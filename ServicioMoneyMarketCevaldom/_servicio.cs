using System;
using System.Diagnostics;
using System.ServiceProcess;
namespace MoneyMarketCevaldom
{
    partial class _servicio : ServiceBase
    {
        bool blBandera = false;
        public _servicio()
        {
            InitializeComponent(); 
        }

        protected override void OnStart(string[] args)
        {
            // TODO: Add code here to start your service.
            stLapso.Start();
        }

        protected override void OnStop()
        {
            WindowsService1.MoneyMarketCevaldom MM = new WindowsService1.MoneyMarketCevaldom();
            stLapso.Stop();
            string _strbody = " SE DETUVO EL SERVICIO DEL ENVIO DE LAS OPERACIONES HACIA CEVALDOM ";
            string _strfilename = "";
            MM.SendMail("Error ENVIO WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
            // TODO: Add code here to perform any tear-down necessary to stop your service.
        }

        private void stLapso_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (blBandera) return;

            try
            {
                WindowsService1.MoneyMarketCevaldom MM = new WindowsService1.MoneyMarketCevaldom();
                MM.GenerarToken();

            }// OnDebug();}
            catch (Exception ex)
            {
                WindowsService1.MoneyMarketCevaldom MM = new WindowsService1.MoneyMarketCevaldom();
                stLapso.Stop();
                string _strbody = " SE DETUVO EL SERVICIO DEL ENVIO DE LAS OPERACIONES HACIA CEVALDOM; ERROR: " + ex.Message;
                string _strfilename = "";
                MM.SendMail("Error ENVIO WS Operaciones - Cevaldom", _strbody, _strfilename.ToString());
                EventLog.WriteEntry(ex.Message, EventLogEntryType.Error);
            }
            blBandera = false;
        }
    }
}
