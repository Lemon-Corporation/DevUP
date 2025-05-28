package ru.lemonade.TaskService.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.TaskService.dto.type.TaskTypeDTO;
import ru.lemonade.TaskService.service.TaskTypeService;
import ru.lemonade.TaskService.settings.ApiPaths;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping(ApiPaths.TASK_TYPES_URL)
public class TaskTypeController {
    private final TaskTypeService taskTypeService;

    @GetMapping
    public List<TaskTypeDTO> getAll() {
        return taskTypeService.getAll();
    }

    @GetMapping("/{id}")
    public TaskTypeDTO getById(@PathVariable long id) {
        return taskTypeService.getById(id);
    }

    @GetMapping("/search")
    public ResponseEntity<Page<TaskTypeDTO>> searchTaskTypes(
            @RequestParam String title,
            Pageable pageable) {
        return ResponseEntity.ok(taskTypeService.searchByTitle(title, pageable));
    }

    @PostMapping
    public TaskTypeDTO create(@Valid @RequestBody TaskTypeDTO dto) {
        return taskTypeService.add(dto);
    }

    @PutMapping("/{id}")
    public TaskTypeDTO update(@PathVariable long id, @Valid @RequestBody TaskTypeDTO dto) {
        return taskTypeService.update(id, dto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable long id) {
        taskTypeService.deleteById(id);
    }
}
