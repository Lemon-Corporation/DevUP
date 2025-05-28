package ru.lemonade.TaskService.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.lemonade.TaskService.dto.type.TaskTypeDTO;
import ru.lemonade.TaskService.mapper.TaskType.TaskTypeMapper;
import ru.lemonade.TaskService.model.task.TaskType;
import ru.lemonade.TaskService.repository.TaskTypeRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class TaskTypeService {
    private final TaskTypeRepository taskTypeRepository;
    private final TaskTypeMapper taskTypeMapper;

    @Transactional(readOnly = true)
    public List<TaskTypeDTO> getAll() {
        return taskTypeRepository.findAll().stream()
                .map(taskTypeMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public TaskTypeDTO getById(Long id) {
        return taskTypeRepository.findById(id)
                .map(taskTypeMapper::toDTO)
                .orElseThrow(() -> new EntityNotFoundException("TaskType not found with id: " + id));
    }

    @Transactional(readOnly = true)
    public Page<TaskTypeDTO> searchByTitle(String title, Pageable pageable) {
        return taskTypeRepository.findByTitleContainingIgnoreCase(title, pageable)
                .map(taskTypeMapper::toDTO);
    }

    public TaskTypeDTO add(TaskTypeDTO taskTypeDTO) {
        TaskType taskType = taskTypeMapper.toEntity(taskTypeDTO);
        taskType = taskTypeRepository.save(taskType);
        return taskTypeMapper.toDTO(taskType);
    }

    public TaskTypeDTO update(Long id, TaskTypeDTO taskTypeDTO) {
        TaskType existingTaskType = taskTypeRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("TaskType not found with id: " + id));
        
        existingTaskType.setTitle(taskTypeDTO.getTitle());
        existingTaskType = taskTypeRepository.save(existingTaskType);
        return taskTypeMapper.toDTO(existingTaskType);
    }

    public void deleteById(Long id) {
        if (!taskTypeRepository.existsById(id)) {
            throw new EntityNotFoundException("TaskType not found with id: " + id);
        }
        taskTypeRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public TaskTypeDTO getTaskTypeByTitle(String title) {
        return taskTypeRepository.findByTitle(title)
                .map(taskTypeMapper::toDTO)
                .orElseThrow(() -> new EntityNotFoundException("TaskType not found with title: " + title));
    }
}
