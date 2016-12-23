using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.Models;

namespace BusinessLayer.Interfaces
{
    public interface IUserBusiness
    {
        Task<bool> Add(UserModel user);

        Task<UserModel> Get(Guid Id);

        Task<bool> Validate(UserLoginModel user);
    }
}
