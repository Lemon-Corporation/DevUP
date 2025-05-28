package ru.lemonade.TaskService.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.lemonade.TaskService.dto.task.TaskComplexityDTO;
import ru.lemonade.TaskService.mapper.TaskComplexity.TaskComplexityMapper;
import ru.lemonade.TaskService.model.task.TaskComplexity;
import ru.lemonade.TaskService.repository.TaskComplexityRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class TaskComplexityService {
    private final TaskComplexityRepository taskComplexityRepository;
    private final TaskComplexityMapper taskComplexityMapper;

    @Transactional(readOnly = true)
    public List<TaskComplexityDTO> getAll() {
        return taskComplexityRepository.findAll().stream()
                .map(taskComplexityMapper::toDto)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public TaskComplexityDTO getById(Long id) {
        return taskComplexityRepository.findById(id)
                .map(taskComplexityMapper::toDto)
                .orElseThrow(() -> new EntityNotFoundException("TaskComplexity not found with id: " + id));
    }

    @Transactional(readOnly = true)
    public List<TaskComplexityDTO> searchByTitle(String title) {
        return taskComplexityRepository.findByTitleContainingIgnoreCase(title).stream()
                .map(taskComplexityMapper::toDto)
                .collect(Collectors.toList());
    }

    public TaskComplexityDTO add(TaskComplexityDTO taskComplexityDTO) {
        TaskComplexity taskComplexity = taskComplexityMapper.toEntity(taskComplexityDTO);
        taskComplexity = taskComplexityRepository.save(taskComplexity);
        return taskComplexityMapper.toDto(taskComplexity);
    }

    public TaskComplexityDTO update(Long id, TaskComplexityDTO taskComplexityDTO) {
        TaskComplexity existingTaskComplexity = taskComplexityRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("TaskComplexity not found with id: " + id));
        
        existingTaskComplexity.setTitle(taskComplexityDTO.getTitle());
        existingTaskComplexity.setSortOrder(taskComplexityDTO.getSortOrder());
        existingTaskComplexity = taskComplexityRepository.save(existingTaskComplexity);
        return taskComplexityMapper.toDto(existingTaskComplexity);
    }

    public void deleteById(Long id) {
        if (!taskComplexityRepository.existsById(id)) {
            throw new EntityNotFoundException("TaskComplexity not found with id: " + id);
        }
        taskComplexityRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public TaskComplexityDTO getByTitle(String title) {
        return taskComplexityRepository.findByTitle(title)
                .map(taskComplexityMapper::toDto)
                .orElseThrow(() -> new EntityNotFoundException("TaskComplexity not found with title: " + title));
    }
}
