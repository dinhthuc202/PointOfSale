using OpenQA.Selenium.Chrome;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using static System.Collections.Specialized.BitVector32;
using OpenQA.Selenium.DevTools.V120.Console;
using crawl_data_on_web.models;
using Newtonsoft.Json;
using System.Text;

IWebDriver chromeDriver;
chromeDriver = new ChromeDriver();
chromeDriver.Url = "https://www.thegioididong.com/dtdd";
chromeDriver.Navigate();
chromeDriver.Manage().Window.Maximize();

//Chờ trang load xong
new WebDriverWait(chromeDriver, TimeSpan.FromSeconds(10)).Until(d => ((IJavaScriptExecutor)d).ExecuteScript("return document.readyState").Equals("complete"));

var nodeItem = chromeDriver.FindElements(By.XPath("/html/body/div[6]/section/div[3]/ul/li/a[1]"));


foreach (var node in nodeItem)
{
    ProductInput productInput = new ProductInput();
    productInput.Name = node.GetAttribute("data-name");
    productInput.SalePrice =decimal.Parse(node.GetAttribute("data-price"));
    productInput.PurchasePrice = productInput.SalePrice * 0.8m;
    IWebElement nodeImage = node.FindElement(By.XPath("./div[2]/img"));
    productInput.Image = nodeImage.GetAttribute("src");
    productInput.SupplierId = 0;

    string jsonProduct = JsonConvert.SerializeObject(productInput);
    string apiUrl = "http://127.0.0.1:90/api/Product";

    using (HttpClient client = new HttpClient())
    {
        var content = new StringContent(jsonProduct, Encoding.UTF8, "application/json");

        HttpResponseMessage response = await client.PostAsync(apiUrl, content);

        if (response.IsSuccessStatusCode)
        {
            Console.WriteLine("Yêu cầu POST đã thành công!");
        }
        else
        {
            Console.WriteLine("Yêu cầu POST không thành công. Mã trạng thái: " + response.StatusCode);
        }
    }
}