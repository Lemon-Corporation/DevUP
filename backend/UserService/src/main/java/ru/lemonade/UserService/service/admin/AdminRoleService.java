package ru.lemonade.UserService.service.admin;

import org.springframework.stereotype.Service;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.repository.RoleRepository;

import java.util.List;

@Service
public class AdminRoleService {
    RoleRepository repository;
    public AdminRoleService(RoleRepository repository) {
        this.repository = repository;
    }
    public Role getRole(String roleName) throws RoleNotFoundException {
        return repository.getByTitle(roleName).orElseThrow(() -> new RoleNotFoundException("No role with title: " + roleName));
    }
    public Role getRoleById(long id) throws RoleNotFoundException {
        return repository.findById(id).orElseThrow(() -> new RoleNotFoundException("Not such role with id: " + id));
    }
    public List<Role> getAllRoles() {
        return repository.findAll();
    }
    public void createRole(Role role) {
        repository.save(role);
    }
    public void createRolesMultiple(List<Role> roles) {
        repository.saveAll(roles);
    }
}
