﻿namespace MoneyMarketCevaldom
{
    partial class _servicio
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.stLapso = new System.Timers.Timer();
            ((System.ComponentModel.ISupportInitialize)(this.stLapso)).BeginInit();
            // 
            // stLapso
            // 
            this.stLapso.Enabled = true;
            this.stLapso.Interval = 60000D;
            this.stLapso.Elapsed += new System.Timers.ElapsedEventHandler(this.stLapso_Elapsed);
            // 
            // _servicio
            // 
            this.CanHandlePowerEvent = true;
            this.CanHandleSessionChangeEvent = true;
            this.CanPauseAndContinue = true;
            this.CanShutdown = true;
            this.ServiceName = "_EnvioOperacionesCevaldom";
            ((System.ComponentModel.ISupportInitialize)(this.stLapso)).EndInit();

        }

        #endregion

        private System.Timers.Timer stLapso;
    }
}
