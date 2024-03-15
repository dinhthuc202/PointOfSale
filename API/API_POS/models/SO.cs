using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class SO
    {
        public string? Id { get; set; } = null!;
        public int? Soserial { get; set; }
        public decimal BillAmount { get; set; }
        public decimal BillPaid { get; set; }
        public decimal? Discount { get; set; }
        public decimal? Balance { get; set; }
        public decimal? PrevBalance { get; set; }
        public DateTime Date { get; set; }
        public bool? SaleReturn { get; set; }
        public int? CustomerId { get; set; }
        public int? Sodid { get; set; }
        public decimal? SaleOrderAmount { get; set; }
        public decimal? SaleReturnAmount { get; set; }
        public decimal? SaleOrderQty { get; set; }
        public decimal? SaleReturnQty { get; set; }
        public decimal? Profit { get; set; }
        public string? PaymentMethod { get; set; }
        public string? PaymentDetail { get; set; }
        public string? Remarks { get; set; }
        public string? Remarks2 { get; set; }
        public long? EmployeeId { get; set; }
        //public List<SOD> sODs { get; set; } = null!;
    }

    public class SOInput
    {
        public decimal BillAmount { get; set; }
        public decimal BillPaid { get; set; }
        public decimal? Discount { get; set; }
        public decimal? Balance { get; set; }
        public decimal? PrevBalance { get; set; }
        public bool? SaleReturn { get; set; }
        public int? CustomerId { get; set; }
        public int? Sodid { get; set; }
        public decimal? SaleOrderAmount { get; set; }
        public decimal? SaleReturnAmount { get; set; }
        public decimal? SaleOrderQty { get; set; }
        public decimal? SaleReturnQty { get; set; }
        //public decimal? Profit { get; set; }
        //public string? PaymentMethod { get; set; }
        //public string? PaymentDetail { get; set; }
        //public string? Remarks { get; set; }
        //public string? Remarks2 { get; set; }
        public long? EmployeeId { get; set; }
        public List<SODInput> sods { get; set; } = null!;
    }
}
