using PhoneFinder.DAL;
using PhoneFinder.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace PhoneFinder.Controllers
{
    public class HomeController : Controller 
    {
        public ActionResult Index()
        {
            var filteredPhone = TempData["FilteredPhone"] as List<Phone>;
            //DBContext.GetData(out var brandList, out var osList);
            if(Session["Brandlist"]!=null && Session["OSlist"]!=null)
            {
                ViewBag.Brandlist = Session["Brandlist"];
                ViewBag.OSlist = Session["OSlist"];
            }
            else
            {
               DBContext.GetData(out var brandList, out var osList);
                Session["BrandList"] = brandList;
                ViewBag.BrandList = brandList;
                
                Session["OSList"] = osList;
                ViewBag.OSList = osList;
            }
           
 
            if (filteredPhone != null)
            {
               
                return View(filteredPhone);
            }
            else
            {
                DBContext.GetPhoneList(out var phoneList);
                    Session["PhoneList"] = phoneList;
                List<Phone> model = phoneList;
                    return View(model);
            }
        }

        public ActionResult GetFilteredList(int brandid,int osid)
        {
            //var brandId = id;

            List<Phone> model = Session["PhoneList"] as List<Phone>;
            if (brandid != 0)
            { model = model.Where(item => item.BrandId == brandid).ToList<Phone>(); }
            else
            {
                model = model.Where(item => item.OSId == osid).ToList<Phone>();
            }
            TempData["FilteredPhone"] = model;
            return RedirectToAction("Index");
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
        public ActionResult GetDetailList(int id)
        {
            DBContext.GetDetailList(out var phonedetail, id);


            return View("DetailedPage", phonedetail);
        }
    }

   
}