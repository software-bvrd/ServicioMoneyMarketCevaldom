using MoneyMarketCevaldom;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace WindowsService1
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {

#if DEBUG
             
            //Subo el Servicio.
         /*   ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
               new _servicio()
            };
            ServiceBase.Run(ServicesToRun);
            */
            //Consulto el proceso de busqueda de informacion la enviar a Cevaldom
            MoneyMarketCevaldom MM = new MoneyMarketCevaldom();
            MM.OnDebug();
            //MM.aleatorio();
            // MM.RandomNumber();


#else
                        ServiceBase[] ServicesToRun;
                        ServicesToRun = new ServiceBase[]
                        {
                            new _servicio()

                        };
                        ServiceBase.Run(ServicesToRun);
#endif
            /*
             ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
                            new _servicio()
            };
            ServiceBase.Run(ServicesToRun);
             */
        }
    }
}
