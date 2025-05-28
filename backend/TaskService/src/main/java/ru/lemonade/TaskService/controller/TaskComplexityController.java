package ru.lemonade.TaskService.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.lemonade.TaskService.dto.task.TaskComplexityDTO;
import ru.lemonade.TaskService.service.TaskComplexityService;
import ru.lemonade.TaskService.settings.ApiPaths;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping(ApiPaths.TASK_COMPLEXITIES_URL)
public class TaskComplexityController {
    private final TaskComplexityService taskComplexityService;

    @GetMapping
    public List<TaskComplexityDTO> getAll() {
        return taskComplexityService.getAll();
    }

    @GetMapping("/{id}")
    public TaskComplexityDTO getById(@PathVariable long id) {
        return taskComplexityService.getById(id);
    }

    @GetMapping("/search")
    public List<TaskComplexityDTO> searchTaskComplexities(@RequestParam String title) {
        return taskComplexityService.searchByTitle(title);
    }

    @PostMapping
    public TaskComplexityDTO create(@Valid @RequestBody TaskComplexityDTO dto) {
        return taskComplexityService.add(dto);
    }

    @PutMapping("/{id}")
    public TaskComplexityDTO update(@PathVariable long id, @Valid @RequestBody TaskComplexityDTO dto) {
        return taskComplexityService.update(id, dto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable long id) {
        taskComplexityService.deleteById(id);
    }
} 