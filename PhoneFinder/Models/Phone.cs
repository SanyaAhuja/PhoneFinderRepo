using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;

namespace PhoneFinder.Models
{
 
        public class Phone
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public int BrandId { get; set; }
            public int OSId { get; set; }
            public int Price { get; set; }
            public string Dimension { get; set; }
            public DateTime ReleasedDate { get; set; }
            public bool IsTouch { get; set; }
        //public string ImagePath
        //{
        //    get
        //    {
        //        return "~/Content/Images/samsung galaxy fold.jpg";
        //    }
        //}

        public string ImagePath { get;set; }
    }
 }
