using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.Models;

namespace Repository.Interfaces
{
    public interface IUserRepository
    {
        Task<bool> Add(UserModel user);

        //Task Delete(Guid id);

        Task<UserModel> Get(Guid id);

        Task<bool> Validate(UserLoginModel user);

        Task<bool> Exists(string email);
    }
}
