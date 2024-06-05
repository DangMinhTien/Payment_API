using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Payment_API.Application.Base.Models
{
    public class BaseResultWithData<T> : BaseResult
    {
        public T? Data { get; set; }
        public void Set(bool success, string message, T data)
        {
            this.Success = success;
            this.Message = message;
            this.Data = data;
        }
    }
}
