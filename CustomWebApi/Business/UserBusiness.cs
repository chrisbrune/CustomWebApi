using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.Models;
using Repository.Interfaces;
using Repository.Repositories;
using BusinessLayer.Interfaces;

namespace BusinessLayer
{
    public class UserBusiness:IUserBusiness
    {
        private IUserRepository repository;
    
        public UserBusiness()
        {
            repository = new UserRepository();
        }

        public UserBusiness(IUserRepository _repository)
        {
            repository = _repository;
        }

        public async Task<bool> Add(UserModel user)
        {
            if(await repository.Exists(user.Email))
            {
                return false;

            }
            
            return await repository.Add(user);
        }

        public async Task<UserModel> Get(Guid Id)
        {

            return await repository.Get(Id);
        }

        public async Task<bool> Validate(UserLoginModel user)
        {
            return await repository.Validate(user);
        }
    }
}
