using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class Payment
    {
        public int Id { get; set; }
        public string? Soid { get; set; }//Khóa liên kết với bảng SO
        public string? PaymentMethod { get; set; }//Phương thức thanh toán
        public decimal PaymentAmount { get; set; }//Số tiền thanh toán
        public DateTime ReceivedDate { get; set; }//Ngày nhận thanh toán
        public string? Remarks { get; set; }//ghi chú

    }
}
