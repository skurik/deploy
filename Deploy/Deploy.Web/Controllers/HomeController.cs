using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Deploy.Web.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var connectionStringName = "mews-develop-sql-weu/mews-develop-db";
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            ViewBag.ConnectionString = connectionString;
            //var connection = new SqlConnection(connectionString);
            //connection.Open();

            //using (var tx = connection.BeginTransaction())
            //{
            //    tx.Commit();
            //}

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}