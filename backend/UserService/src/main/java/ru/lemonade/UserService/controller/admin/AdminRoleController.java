package ru.lemonade.UserService.controller.admin;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.UserService.error.exception.RoleNotFoundException;
import ru.lemonade.UserService.model.Role;
import ru.lemonade.UserService.service.admin.AdminRoleService;
import ru.lemonade.UserService.settings.ApiPath;

import java.util.List;

@RestController
@RequestMapping(ApiPath.ROLE_CONTROLLER_PATH)
@PreAuthorize("hasRole('ROLE_ADMIN')")
@SecurityRequirement(name = "JWT")
@Tag(
        name = "Role Controller",
        description = "allows to manage roles. ONLY for admins"
)
public class AdminRoleController {
    AdminRoleService adminRoleService;
    public AdminRoleController(AdminRoleService adminRoleService) {
        this.adminRoleService = adminRoleService;
    }

    @GetMapping("all")
    public List<Role> getAll() {
        return adminRoleService.getAllRoles();
    }

    @GetMapping("{id}")
    public Role getById(@PathVariable long id) throws RoleNotFoundException {
        return adminRoleService.getRoleById(id);
    }

    @PostMapping("create")
    public void createRole(@RequestBody Role role) {
        adminRoleService.createRole(role);
    }

    @PostMapping("create_multiple")
    public void createMultipleRoles(@RequestBody List<Role> roles) {
        adminRoleService.createRolesMultiple(roles);
    }

}
