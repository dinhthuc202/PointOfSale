using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace API_POS.models
{
    public class Customer
    {
        public int? Id { get; set; }
        [Required]
        public string? Name { get; set; }
        [Required]
        public string? Address { get; set; }
        public decimal? Balance { get; set; }
        public string? Remarks { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public string? BizId { get; set; }
    }

    public class CustomerInput
    {
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        public string Address { get; set; } = string.Empty;
        public decimal? Balance { get; set; }
        public string? Remarks { get; set; }
        public string? BizId { get; set; }
    }
    public class CustomerEdit:CustomerInput
    {
        [Required]
        public int Id { get; set; }

    }
}
