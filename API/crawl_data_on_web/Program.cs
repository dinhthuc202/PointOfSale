//using OpenQA.Selenium.Chrome;
//using OpenQA.Selenium;
//using OpenQA.Selenium.Support.UI;
//using static System.Collections.Specialized.BitVector32;
//using OpenQA.Selenium.DevTools.V120.Console;
//using crawl_data_on_web.models;
//using Newtonsoft.Json;
//using System.Text;
//using OpenQA.Selenium.Interactions;
//using System.Xml.Linq;

//IWebDriver chromeDriver;
//chromeDriver = new ChromeDriver();
//chromeDriver.Url = "https://www.thegioididong.com/dong-ho-thong-minh#c=7077&o=17&pi=1";
//chromeDriver.Navigate();
//chromeDriver.Manage().Window.Maximize();

////Chờ trang load xong
//new WebDriverWait(chromeDriver, TimeSpan.FromSeconds(10)).Until(d => ((IJavaScriptExecutor)d).ExecuteScript("return document.readyState").Equals("complete"));
//Thread.Sleep(1000);

//var nodeItem = chromeDriver.FindElements(By.XPath("/html/body/div[6]/section/div[3]/ul/li/a[1]"));
////html/body/div[6]/section/div[3]/ul/li[22]/a[1]

//foreach (var node in nodeItem)
//{
//    ProductInput productInput = new ProductInput();
//    productInput.Name = node.GetAttribute("data-name");
//    productInput.SalePrice =decimal.Parse(node.GetAttribute("data-price"));
//    productInput.PurchasePrice = productInput.SalePrice * 0.8m;
//    IWebElement nodeImage = node.FindElement(By.XPath("./div[2]/img"));
//    productInput.Image = nodeImage.GetAttribute("src");
//    productInput.SupplierId = 0;

//    string jsonProduct = JsonConvert.SerializeObject(productInput);
//    string apiUrl = "http://127.0.0.1:90/api/Product";

//    using (HttpClient client = new HttpClient())
//    {
//        var content = new StringContent(jsonProduct, Encoding.UTF8, "application/json");

//        HttpResponseMessage response = await client.PostAsync(apiUrl, content);

//        if (response.IsSuccessStatusCode)
//        {
//            Console.WriteLine("Yêu cầu POST đã thành công!");
//        }
//        else
//        {
//            Console.WriteLine("Yêu cầu POST không thành công. Mã trạng thái: " + response.StatusCode);
//        }
//    }
//    Thread.Sleep(100);
//    //di chuột đến vùng chỉ định
//    Actions actions = new Actions(chromeDriver);
//    actions.MoveToElement(node).Perform();
//}



using System;
using System.Threading;

class Program
{
    static void Main(string[] args)
    {
        // Tạo một đối tượng Semaphore với giá trị ban đầu là 0.
        Semaphore semaphore = new Semaphore(0, 1);

        // Tạo và khởi chạy luồng 1.
        Thread thread1 = new Thread(() =>
        {
            Console.WriteLine("Luồng 1 bắt đầu.");
            // Sau khi semaphore được tăng lên, luồng 1 thực hiện công việc của mình.
            Console.WriteLine("Luồng 1 thực hiện công việc trong 1 giây.");
            Thread.Sleep(1000);
            // Luồng 1 chờ đợi cho đến khi semaphore được tăng lên.

            semaphore.WaitOne();
            Console.WriteLine("Luồng 1 kết thúc.");
        });
        thread1.Start();

        // Tạo và khởi chạy luồng 2.
        Thread thread2 = new Thread(() =>
        {
            Console.WriteLine("Luồng 2 bắt đầu.");
            // Luồng 2 thực hiện công việc của mình trong 2 giây.
            Console.WriteLine("Luồng 2 thực hiện công việc trong 2 giây.");
            Thread.Sleep(2000);
            // Sau khi công việc của luồng 2 hoàn thành, tăng giá trị của semaphore lên.
            semaphore.Release();
            Console.WriteLine("Luồng 2 kết thúc.");
        });
        thread2.Start();

        // Chờ cho đến khi cả hai luồng đều kết thúc.
        thread1.Join();
        thread2.Join();

        Console.WriteLine("Cả hai luồng đã kết thúc.");
    }
}
